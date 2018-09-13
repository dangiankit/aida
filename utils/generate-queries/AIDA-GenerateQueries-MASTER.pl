#!/usr/bin/perl
use strict;

use GenerateQueriesManagerLib;

my $logger = Logger->new();
my $error_filename = "output/problems.log";
$logger->set_error_output($error_filename);
my $error_output = $logger->get_error_output();

my $postfix = "_original";

my $nodes_data_files = Container->new("String");
$nodes_data_files->add("input/annotations-local/data/T101$postfix/T101_ent_mentions.tab");
$nodes_data_files->add("input/annotations-local/data/T101$postfix/T101_evt_mentions.tab");
$nodes_data_files->add("input/annotations-local/data/T101$postfix/T101_rel_mentions.tab");

my $edge_data_files = Container->new("String");
$edge_data_files->add("input/annotations-local/data/T101$postfix/T101_evt_slots.tab");
$edge_data_files->add("input/annotations-local/data/T101$postfix/T101_rel_slots.tab");

my $acceptable_relevance = Container->new("String");
$acceptable_relevance->add("fully-relevant");

my $parameters = Parameters->new($logger);
$parameters->set("TOPICID", "T101");
$parameters->set("HYPOTHESISID", "T101_Q002_H002");
$parameters->set("IGNORE_NIL", "true");
$parameters->set("DOCUMENTIDS_MAPPING_FILE", "input/DocumentIDsMappings.ttl");
$parameters->set("ROLE_MAPPING_FILE","input/nist-role-mapping.txt");
$parameters->set("TYPE_MAPPING_FILE","input/nist-type-mapping.txt");
$parameters->set("UID_INFO_FILE", "input/uid_info.tab");
$parameters->set("HYPOTHESES_FILE", "input/annotations-local/data/T101$postfix/T101_hypotheses.tab");
$parameters->set("NODES_DATA_FILES", $nodes_data_files);
$parameters->set("EDGES_DATA_FILES", $edge_data_files);
$parameters->set("ACCEPTABLE_RELEVANCE", $acceptable_relevance);
$parameters->set("IMAGES_BOUNDINGBOXES_FILE", "input/images_boundingboxes.tab");
$parameters->set("KEYFRAMES_BOUNDINGBOXES_FILE", "input/keyframes_boundingboxes.tab");
$parameters->set("ENCODINGFORMAT_TO_MODALITYMAPPING_FILE", "input/encodingformat_modality.tab");
$parameters->set("CANONICAL_MENTIONS_FILE", "input/canonical_mentions/canonical_mentions$postfix/T101_canonical_mentions.tsv");
$parameters->set("ERRORLOG_FILE", "output$postfix/problems.log");
$parameters->set("CLASS_QUERIES_XML_OUTPUT_FILE", "output$postfix/T101_class_queries.xml");
$parameters->set("ZEROHOP_QUERIES_XML_OUTPUT_FILE", "output$postfix/T101_zerohop_queries.xml");
$parameters->set("GRAPH_QUERIES_XML_OUTPUT_FILE", "output$postfix/T101_graph_queries.xml");
$parameters->set("CLASS_QUERIES_PREFIX", "AIDA_CL_2018");
$parameters->set("ZEROHOP_QUERIES_PREFIX", "AIDA_ZH_2018");
$parameters->set("GRAPH_QUERIES_SUBPREFIX", "AIDA_GR_2018");

my $graph = Graph->new($logger, $parameters);
$graph->generate_queries();

my ($num_errors, $num_warnings) = $logger->report_all_information();
print "Problems encountered (warnings: $num_warnings, errors: $num_errors)\n" if ($num_errors || $num_warnings);
print "No problems encountered.\n" unless ($num_errors || $num_warnings);
print $error_output ($num_warnings || 'No'), " warning", ($num_warnings == 1 ? '' : 's'), " encountered\n";
exit 0;
