import SwiftUI
import Combine

struct StoriesView: View {
    private struct Configuration {
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
    
    private let configuration: Configuration
    private var currentStory: Story { viewModel.stories[currentStoryIndex] }
    private var currentStoryIndex: Int {
        let indexFromProgress = Int(progress * CGFloat(viewModel.stories.count))
        return indexFromProgress
        //        return max(indexFromProgress, startStoryIndex)
    }
    private var startStoryIndex: Int
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    @Binding var path: [Route]
    @Binding var viewModel: MainViewModel
    
    init(startStoryIndex: Int, path: Binding<[Route]>, viewModel: Binding<MainViewModel>) {
        self.startStoryIndex = startStoryIndex
        _path = path
        _viewModel = viewModel
        configuration = Configuration(storiesCount: viewModel.stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: viewModel.stories.count, progress: progress)
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
            progress = CGFloat(startStoryIndex) / CGFloat(viewModel.stories.count)
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
            viewModel.stories[currentStoryIndex].isViewed = true
        }
    }
    
    private func nextStory() {
        if currentStoryIndex < viewModel.stories.count - 1 {
            withAnimation {
                progress = CGFloat(currentStoryIndex + 1) / CGFloat(viewModel.stories.count)
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
                progress = CGFloat(currentStoryIndex - 1) / CGFloat(viewModel.stories.count)
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
