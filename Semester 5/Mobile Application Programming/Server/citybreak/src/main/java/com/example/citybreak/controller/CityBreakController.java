package com.example.citybreak.controller;
import com.example.citybreak.converter.CityBreakConverter;
import com.example.citybreak.dto.CityBreakDTO;
import com.example.citybreak.model.CityBreak;
import com.example.citybreak.repository.CityBreakRepository;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.Set;


@RestController
public class CityBreakController {

    private CityBreakRepository cityBreakRepository;

    private CityBreakConverter cityBreakConverter;

    public CityBreakController(CityBreakRepository cityBreakRepository, CityBreakConverter cityBreakConverter){
        this.cityBreakRepository = cityBreakRepository;
        this.cityBreakConverter = cityBreakConverter;
    }

    @GetMapping("/cityBreaks")
    public Set<CityBreakDTO> retrieveAllCityBreaks(){
        System.out.println("GET ALL");
        return cityBreakConverter.convertModelsToDtos(cityBreakRepository.findAll());
    }

    @PostMapping("/cityBreaks")
    public CityBreak createStory(@RequestBody CityBreak cityBreak){
        System.out.println("POST");

        return cityBreakRepository.save(cityBreak);
    }

    @DeleteMapping("/cityBreaks/{id}")
    public CityBreak deleteStory(@PathVariable long id) {
        System.out.println("DELETE");
        Optional<CityBreak> citybreakOptional = cityBreakRepository.findById(id);

        if(citybreakOptional.isEmpty()){
            return null;
        }

        cityBreakRepository.deleteById(id);
        return citybreakOptional.get();
    }

    @PutMapping("/cityBreaks/{id}")
        public CityBreak updateStory(@PathVariable long id, @RequestBody CityBreak cityBreak){
        System.out.println("PUT");
        Optional<CityBreak> cityBreakOptional = cityBreakRepository.findById(id);

        if(cityBreakOptional.isEmpty()){
            return null;
        }

        cityBreak.setId(id);
        return cityBreakRepository.save(cityBreak);
    }

}