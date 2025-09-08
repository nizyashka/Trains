import SwiftUI
import Combine

struct StoriesView: View {
    struct Configuration {
        let timerTickInternal: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInternal: TimeInterval = 0.05
        ) {
            self.timerTickInternal = timerTickInternal
            self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
        }
    }
    
    @Binding var stories: [Story]
    private let configuration: Configuration
    private var currentStory: Story { stories[currentStoryIndex] }
    private var currentStoryIndex: Int {
        let indexFromProgress = Int(progress * CGFloat(stories.count))
        return indexFromProgress
        //        return max(indexFromProgress, startStoryIndex)
    }
    private var startStoryIndex: Int
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    @Binding var path: [Route]
    
    init(stories: Binding<[Story]>, startStoryIndex: Int, path: Binding<[Route]>) {
        _stories = stories
        self.startStoryIndex = startStoryIndex
        _path = path
        configuration = Configuration(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            HStack(spacing: 0) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        previousStory()
                        resetTimer()
                    }
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        nextStory()
                        resetTimer()
                    }
            }
            
            Button("", image: .close) {
                path = []
            }
            .padding(.top, 57)
            .padding(.trailing, 12)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            timer = Self.createTimer(configuration: configuration)
            progress = CGFloat(startStoryIndex) / CGFloat(stories.count)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let horizontalAmount = value.translation.width
                    let verticalAmount = value.translation.height
                    
                    if abs(horizontalAmount) > abs(verticalAmount) {
                        if horizontalAmount < 0 {
                            nextStory()
                            resetTimer()
                        } else {
                            previousStory()
                            resetTimer()
                        }
                    }
                }
        )
        //        .onTapGesture {
        //            nextStory()
        //            previousStory()
        //            resetTimer()
        //        }
    }
    
    private func timerTick() {
        let nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            cancellable?.cancel()
            path = []
        } else {
            progress = nextProgress
            stories[currentStoryIndex].isViewed = true
        }
    }
    
    private func nextStory() {
        if currentStoryIndex < stories.count - 1 {
            withAnimation {
                progress = CGFloat(currentStoryIndex + 1) / CGFloat(stories.count)
                //                stories[currentStoryIndex].isViewed = true
            }
        } else {
            cancellable?.cancel()
            path = []
        }
    }
    
    private func previousStory() {
        if currentStoryIndex == 0 {
            progress = 0
        } else {
            withAnimation {
                progress = CGFloat(currentStoryIndex - 1) / CGFloat(stories.count)
                //                stories[currentStoryIndex].isViewed = true
            }
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: Configuration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

#Preview {
    @Previewable @State var stories: [Story] = [.story1, .story2, .story3]
    @Previewable @State var path: [Route] = []
    
    StoriesView(stories: $stories, startStoryIndex: 0, path: $path)
}
