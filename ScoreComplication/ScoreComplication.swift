import WidgetKit
import SwiftUI

// MARK: - Timeline Provider
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, configuration: configuration)
        let timeline = Timeline(entries: [entry], policy: .never)
        return timeline
    }

    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "Abrir marcador de raquetbol")]
    }
}

// MARK: - Timeline Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

// MARK: - Complication View
struct ScoreComplicationEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("11/10 🔵")
            .widgetURL(URL(string: "eleventen://scoreview")) // 👈 Toca para abrir la app
    }
}

// MARK: - Widget
@main
struct ScoreComplication: Widget {
    let kind: String = "ScoreComplication"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ScoreComplicationEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([
            .accessoryInline,
            .accessoryCircular,
            .accessoryRectangular
        ])
        .configurationDisplayName("Marcador Raquetbol")
        .description("Muestra una pelota azul y abre el marcador al tocarla.")
    }
}

// MARK: - Preview
#Preview(as: .accessoryInline) {
    ScoreComplication()
} timeline: {
    SimpleEntry(date: .now, configuration: ConfigurationAppIntent())
}
