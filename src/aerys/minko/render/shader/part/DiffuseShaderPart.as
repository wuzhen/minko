package aerys.minko.render.shader.part
{
	import aerys.minko.render.shader.SFloat;
	import aerys.minko.render.shader.Shader;
	import aerys.minko.type.enum.SamplerFiltering;
	import aerys.minko.type.enum.SamplerMipMapping;
	import aerys.minko.type.enum.SamplerWrapping;
	import aerys.minko.type.stream.format.VertexComponent;
	
	public class DiffuseShaderPart extends ShaderPart
	{
		/**
		 * The shader part to use a diffuse map or fallback and use a solid color.
		 *  
		 * @param main
		 * 
		 */
		public function DiffuseShaderPart(main : Shader)
		{
			super(main);
		}
		
		public function getDiffuse() : SFloat
		{
			if (meshBindings.propertyExists("diffuseMap"))
			{
				var diffuseMap	: SFloat	= meshBindings.getTextureParameter(
					"diffuseMap",
					meshBindings.getConstant("diffuseFiltering", SamplerFiltering.LINEAR),
					meshBindings.getConstant("diffuseMipMapping", SamplerMipMapping.LINEAR),
					meshBindings.getConstant("diffuseWrapping", SamplerWrapping.REPEAT)
				);
				
				var uv : SFloat = getVertexAttribute(VertexComponent.UV);
				uv = uv.xy;
				
				return sampleTexture(
					diffuseMap,
					interpolate(uv)
				);
			}
			else if (meshBindings.propertyExists("diffuseColor"))
			{
				return meshBindings.getParameter("diffuseColor", 4);
			}
			
			throw new Error(
				"Local parameter 'diffuseColor' or 'diffuseMap' must be set."
			);
		}
	}
}