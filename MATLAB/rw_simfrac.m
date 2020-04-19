function [mensaje]=rw_simfrac(numerador,denominador)
    function [dv]=mcd(numerador,denominador)
        if(numerador < denominador)
            dv=mcd(denominador,numerador);
        elseif(denominador==0)
            dv=numerador;
        else
            dv=mcd(denominador,mod(numerador,denominador));
        end
    end
    comundivisor=mcd(numerador,denominador);
    mensaje=strcat('Francción simplificada: ',string(numerador/comundivisor),'/',string(denominador/comundivisor));
end

