allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Enforce Java 11 compilation options for all subprojects to avoid legacy Java 8 warnings
subprojects {
    // Configure JavaCompile tasks to use Java 11 where present
    tasks.matching { it.name == "compileKotlin" || it.name.startsWith("compile") }.configureEach {
        try {
            if (this is org.gradle.api.tasks.compile.JavaCompile) {
                sourceCompatibility = org.gradle.api.JavaVersion.VERSION_11.toString()
                targetCompatibility = org.gradle.api.JavaVersion.VERSION_11.toString()
            }
        } catch (_: Throwable) {
            // ignore
        }
    }

    // Configure Kotlin jvmTarget
    try {
        tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile::class.java).configureEach {
            kotlinOptions {
                jvmTarget = org.gradle.api.JavaVersion.VERSION_11.toString()
            }
        }
    } catch (_: Throwable) {
        // ignore
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
