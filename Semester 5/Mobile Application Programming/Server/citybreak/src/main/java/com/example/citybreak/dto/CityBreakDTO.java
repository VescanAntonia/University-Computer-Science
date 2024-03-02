package com.example.citybreak.dto;


import lombok.*;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class CityBreakDTO {

    private Long id;

    private String city;

    private String country;

    private String startDate;

    private String endDate;

    private String description;

    private String accommodation;

    private String budget;
}