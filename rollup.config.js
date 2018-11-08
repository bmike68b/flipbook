import riot from 'rollup-plugin-riot'
import nodeResolve from 'rollup-plugin-node-resolve'
import commonjs from 'rollup-plugin-commonjs'

export default {
  plugins: [
    riot(),
    nodeResolve({ jsnext: true }),
    commonjs()
  ],
  input: 'src/main.js',
  output: [{
    name: 'nisiu',
    sourcemap: true,
    file: 'dist/main.js',
    format: 'umd'
  }]
}
