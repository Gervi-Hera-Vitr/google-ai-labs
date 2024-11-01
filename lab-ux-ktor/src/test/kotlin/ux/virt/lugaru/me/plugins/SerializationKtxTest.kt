package ux.virt.lugaru.me.plugins

import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.testing.*
import ux.virt.lugaru.me.module
import kotlin.test.Test
import kotlin.test.assertEquals

class SerializationKtxTest {

    /**
     * Tests that the KotlinX-Serialization plugin properly serializes data classes into JSON.
     *
     * Asserts that the route "/json-ml" responds with a JSON object containing the key-value pair
     * "hello" -> "json ML".
     */
    @Test
    fun testGetJsonKotlinXSerialization() = testApplication {
        application(Application::module)

        client.get("/json-ml") { ContentType.Application.Json.withCharset(Charsets.UTF_8) }.apply {
            assertEquals(HttpStatusCode.OK, status)
            assertEquals(
                """
                {
                    "hello": "json ML"
                }""".trimIndent(), bodyAsText()
            )
        }
    }
}