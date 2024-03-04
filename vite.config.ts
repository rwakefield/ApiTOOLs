import path from 'path'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  root: path.resolve(__dirname, 'src'),
    resolve: {
    alias: {
      '~bootstrap': path.resolve(__dirname, 'node_modules/bootstrap'),
    }
  },
  plugins: [
    RubyPlugin(),
  ],
  server: {
    hmr: {
      host: "localhost",
      protocol: "ws",
    },
  },
})
