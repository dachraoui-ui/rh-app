--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12 (Debian 15.12-1.pgdg120+1)
-- Dumped by pg_dump version 15.12 (Debian 15.12-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO admin;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO admin;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO admin;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO admin;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO admin;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO admin;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO admin;

--
-- Name: client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO admin;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO admin;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO admin;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO admin;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO admin;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO admin;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO admin;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO admin;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO admin;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO admin;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO admin;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO admin;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO admin;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO admin;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO admin;

--
-- Name: component; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO admin;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO admin;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO admin;

--
-- Name: condidat; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.condidat (
    id_condidat bigint NOT NULL,
    cv character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    statut smallint NOT NULL,
    CONSTRAINT condidat_statut_check CHECK (((statut >= 0) AND (statut <= 2)))
);


ALTER TABLE public.condidat OWNER TO admin;

--
-- Name: condidat_id_condidat_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.condidat ALTER COLUMN id_condidat ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.condidat_id_condidat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: conge; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conge (
    id_conge bigint NOT NULL,
    date_debut timestamp(6) without time zone NOT NULL,
    date_fin timestamp(6) without time zone NOT NULL,
    description character varying(255),
    statut smallint NOT NULL,
    type character varying(255) NOT NULL,
    CONSTRAINT conge_statut_check CHECK (((statut >= 0) AND (statut <= 2)))
);


ALTER TABLE public.conge OWNER TO admin;

--
-- Name: conge_id_conge_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.conge ALTER COLUMN id_conge ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.conge_id_conge_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contrat; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contrat (
    id_contrat bigint NOT NULL,
    date_debut timestamp(6) without time zone NOT NULL,
    date_fin timestamp(6) without time zone NOT NULL,
    contrat_type character varying(255) NOT NULL,
    salaire double precision NOT NULL
);


ALTER TABLE public.contrat OWNER TO admin;

--
-- Name: contrat_id_contrat_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.contrat ALTER COLUMN id_contrat ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contrat_id_contrat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO admin;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO admin;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO admin;

--
-- Name: date_affectation; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.date_affectation (
    id_date_affectation bigint NOT NULL,
    date_debut date,
    date_fin date,
    employee_id bigint NOT NULL,
    tache_id bigint NOT NULL
);


ALTER TABLE public.date_affectation OWNER TO admin;

--
-- Name: date_affectation_id_date_affectation_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.date_affectation ALTER COLUMN id_date_affectation ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.date_affectation_id_date_affectation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO admin;

--
-- Name: department; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.department (
    id bigint NOT NULL,
    description character varying(255),
    nom character varying(255)
);


ALTER TABLE public.department OWNER TO admin;

--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.department ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: document; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.document (
    id_demande_doc bigint NOT NULL,
    statut smallint NOT NULL,
    type_doc character varying(255) NOT NULL,
    CONSTRAINT document_statut_check CHECK (((statut >= 0) AND (statut <= 1)))
);


ALTER TABLE public.document OWNER TO admin;

--
-- Name: document_id_demande_doc_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.document ALTER COLUMN id_demande_doc ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.document_id_demande_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employee; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee (
    id_employee bigint NOT NULL,
    num_tel character varying(255),
    actif boolean NOT NULL,
    addresse character varying(255),
    date_of_birth date,
    email character varying(255) NOT NULL,
    hire_date date,
    nom character varying(255),
    prenom character varying(255),
    salary numeric(38,2),
    department_id bigint,
    role_id bigint NOT NULL
);


ALTER TABLE public.employee OWNER TO admin;

--
-- Name: employee_id_employee_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.employee ALTER COLUMN id_employee ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.employee_id_employee_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employee_projet_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee_projet_role (
    id_emp_projet_role bigint NOT NULL,
    employee_id bigint NOT NULL,
    projet_id bigint NOT NULL,
    projet_role_id bigint NOT NULL
);


ALTER TABLE public.employee_projet_role OWNER TO admin;

--
-- Name: employee_projet_role_id_emp_projet_role_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.employee_projet_role ALTER COLUMN id_emp_projet_role ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.employee_projet_role_id_emp_projet_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employee_reunion; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee_reunion (
    id_emp_reunion bigint NOT NULL,
    attended boolean NOT NULL,
    role character varying(255),
    employee_id bigint NOT NULL,
    reunion_id bigint NOT NULL
);


ALTER TABLE public.employee_reunion OWNER TO admin;

--
-- Name: employee_reunion_id_emp_reunion_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.employee_reunion ALTER COLUMN id_emp_reunion ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.employee_reunion_id_emp_reunion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO admin;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO admin;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO admin;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO admin;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO admin;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO admin;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO admin;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO admin;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO admin;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO admin;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO admin;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO admin;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO admin;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO admin;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO admin;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO admin;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO admin;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO admin;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO admin;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO admin;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO admin;

--
-- Name: permission; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.permission (
    id_permission bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.permission OWNER TO admin;

--
-- Name: permission_id_permission_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.permission ALTER COLUMN id_permission ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.permission_id_permission_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO admin;

--
-- Name: poste; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.poste (
    id_poste bigint NOT NULL,
    competences character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    salaire double precision NOT NULL,
    titre character varying(255) NOT NULL,
    type_contrat character varying(255) NOT NULL
);


ALTER TABLE public.poste OWNER TO admin;

--
-- Name: poste_id_poste_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.poste ALTER COLUMN id_poste ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.poste_id_poste_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: projet; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.projet (
    id bigint NOT NULL,
    description character varying(255),
    nom character varying(255)
);


ALTER TABLE public.projet OWNER TO admin;

--
-- Name: projet_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.projet ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.projet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO admin;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO admin;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO admin;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO admin;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO admin;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO admin;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO admin;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO admin;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO admin;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO admin;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO admin;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO admin;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO admin;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO admin;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO admin;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO admin;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO admin;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO admin;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO admin;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO admin;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO admin;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO admin;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO admin;

--
-- Name: reunion; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.reunion (
    id_reunion bigint NOT NULL,
    date_debut date,
    pv_reunion character varying(255),
    sujet character varying(255)
);


ALTER TABLE public.reunion OWNER TO admin;

--
-- Name: reunion_id_reunion_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.reunion ALTER COLUMN id_reunion ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reunion_id_reunion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role (
    id_role bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.role OWNER TO admin;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO admin;

--
-- Name: role_id_role_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.role ALTER COLUMN id_role ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.role_id_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_permission (
    id_role_permission bigint NOT NULL,
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_permission OWNER TO admin;

--
-- Name: role_permission_id_role_permission_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.role_permission ALTER COLUMN id_role_permission ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.role_permission_id_role_permission_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: role_projet; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_projet (
    id_role_projet bigint NOT NULL,
    nom_role character varying(255) NOT NULL
);


ALTER TABLE public.role_projet OWNER TO admin;

--
-- Name: role_projet_id_role_projet_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.role_projet ALTER COLUMN id_role_projet ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.role_projet_id_role_projet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO admin;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO admin;

--
-- Name: tache; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tache (
    id_tache bigint NOT NULL,
    description character varying(255),
    statut character varying(255),
    projet_id bigint,
    CONSTRAINT tache_statut_check CHECK (((statut)::text = ANY ((ARRAY['A_FAIRE'::character varying, 'EN_COURS'::character varying, 'TERMINEE'::character varying])::text[])))
);


ALTER TABLE public.tache OWNER TO admin;

--
-- Name: tache_id_tache_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.tache ALTER COLUMN id_tache ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tache_id_tache_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ticket; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ticket (
    id_ticket bigint NOT NULL,
    description character varying(255),
    statut character varying(255),
    employee_id bigint NOT NULL,
    CONSTRAINT ticket_statut_check CHECK (((statut)::text = ANY ((ARRAY['OUVERT'::character varying, 'EN_COURS'::character varying, 'RESOLU'::character varying])::text[])))
);


ALTER TABLE public.ticket OWNER TO admin;

--
-- Name: ticket_id_ticket_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.ticket ALTER COLUMN id_ticket ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ticket_id_ticket_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO admin;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO admin;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO admin;

--
-- Name: user_department; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_department (
    id bigint NOT NULL,
    user_id character varying(255) NOT NULL,
    department_id bigint NOT NULL
);


ALTER TABLE public.user_department OWNER TO admin;

--
-- Name: user_department_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.user_department ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO admin;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO admin;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO admin;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO admin;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO admin;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO admin;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO admin;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO admin;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO admin;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO admin;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO admin;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO admin;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
9471d2e6-02de-474e-9209-3e6580714968	\N	auth-cookie	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	88716f92-a2cf-4f1a-a4d3-fe1dc865674d	2	10	f	\N	\N
3250523f-d314-4a4e-8318-1fa022b0d94a	\N	auth-spnego	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	88716f92-a2cf-4f1a-a4d3-fe1dc865674d	3	20	f	\N	\N
7d5b93f3-360b-43a7-b34d-21ced0ca6835	\N	identity-provider-redirector	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	88716f92-a2cf-4f1a-a4d3-fe1dc865674d	2	25	f	\N	\N
a59bf76e-35e9-4e34-b335-a5262a267852	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	88716f92-a2cf-4f1a-a4d3-fe1dc865674d	2	30	t	fb84776f-4fc8-4d91-9442-fd8a95936a34	\N
6caefa01-5e99-4a9a-9ac6-864012c7c5f3	\N	auth-username-password-form	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	fb84776f-4fc8-4d91-9442-fd8a95936a34	0	10	f	\N	\N
82863eca-692c-4b48-b28a-4fa317d37664	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	fb84776f-4fc8-4d91-9442-fd8a95936a34	1	20	t	a05f1f08-6937-4466-9975-294fe8596703	\N
69e8a840-5d4f-4b79-a64b-6f6ecf83f3ed	\N	conditional-user-configured	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	a05f1f08-6937-4466-9975-294fe8596703	0	10	f	\N	\N
96d3cebb-537e-4030-b7bb-fdaadcb1c26f	\N	auth-otp-form	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	a05f1f08-6937-4466-9975-294fe8596703	0	20	f	\N	\N
11d6ee9b-45d3-4da6-b969-c190b225611b	\N	direct-grant-validate-username	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	ca8ad2ec-1f2b-43f2-aa49-ab209f8024ab	0	10	f	\N	\N
d5df52a6-e80c-4fde-91df-84684617f820	\N	direct-grant-validate-password	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	ca8ad2ec-1f2b-43f2-aa49-ab209f8024ab	0	20	f	\N	\N
bca35a01-e9b8-4533-94fa-1c5fef50b473	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	ca8ad2ec-1f2b-43f2-aa49-ab209f8024ab	1	30	t	f278190a-35d9-444f-9e96-bfba81ff7495	\N
afa1aacb-e47c-4efa-acb6-71f2d4203843	\N	conditional-user-configured	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f278190a-35d9-444f-9e96-bfba81ff7495	0	10	f	\N	\N
67348d01-f30d-45b8-8c61-ad0296346ca0	\N	direct-grant-validate-otp	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f278190a-35d9-444f-9e96-bfba81ff7495	0	20	f	\N	\N
57239ead-6663-4a40-97ff-061aa409f8a2	\N	registration-page-form	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	21243c6b-3795-4407-9f11-f3cd990a789b	0	10	t	a7ab2c67-709b-426f-ae26-770ef5237be1	\N
a25d700d-7665-4d5d-91a8-1b16608a4c5b	\N	registration-user-creation	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	a7ab2c67-709b-426f-ae26-770ef5237be1	0	20	f	\N	\N
0385c343-6264-474a-85e3-29793cd221a6	\N	registration-password-action	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	a7ab2c67-709b-426f-ae26-770ef5237be1	0	50	f	\N	\N
e1a7d931-d347-4093-b7fa-9c0b6a8727cf	\N	registration-recaptcha-action	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	a7ab2c67-709b-426f-ae26-770ef5237be1	3	60	f	\N	\N
a613911b-45d0-4cac-af3f-f1d0f9689036	\N	registration-terms-and-conditions	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	a7ab2c67-709b-426f-ae26-770ef5237be1	3	70	f	\N	\N
35d49207-1c36-4ab3-9128-f9f34d8b49b3	\N	reset-credentials-choose-user	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	8957ed4b-6b0f-4185-9e60-464182460515	0	10	f	\N	\N
068846de-8eb7-4241-bdd2-d30d7db0bc90	\N	reset-credential-email	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	8957ed4b-6b0f-4185-9e60-464182460515	0	20	f	\N	\N
10cb205d-ff49-40c9-b920-2d4b96f9089d	\N	reset-password	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	8957ed4b-6b0f-4185-9e60-464182460515	0	30	f	\N	\N
865e4b80-9937-47e6-a6b7-d6b74044c1d2	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	8957ed4b-6b0f-4185-9e60-464182460515	1	40	t	f414df51-10c6-460e-97d5-bab46d5ada61	\N
427b4abf-8eb4-4652-91f6-9f479cbbfcb7	\N	conditional-user-configured	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f414df51-10c6-460e-97d5-bab46d5ada61	0	10	f	\N	\N
b745abeb-6127-4cf9-8280-fec71eeb75d0	\N	reset-otp	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f414df51-10c6-460e-97d5-bab46d5ada61	0	20	f	\N	\N
cdf48520-450d-4e36-a893-e45f53225a8e	\N	client-secret	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	fbecc78b-5ecb-4911-b6d3-7d245c525bf4	2	10	f	\N	\N
f018914e-f36f-4428-ac37-925514c4e9f1	\N	client-jwt	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	fbecc78b-5ecb-4911-b6d3-7d245c525bf4	2	20	f	\N	\N
48d4f516-e8bf-4856-9870-e12182dde43a	\N	client-secret-jwt	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	fbecc78b-5ecb-4911-b6d3-7d245c525bf4	2	30	f	\N	\N
64a57f42-f176-4732-ae73-d2d2866d70e0	\N	client-x509	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	fbecc78b-5ecb-4911-b6d3-7d245c525bf4	2	40	f	\N	\N
36d6cf96-9b16-4b45-895f-ed8200a3ad6a	\N	idp-review-profile	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	18241412-db05-4a68-aab2-bb6d23cf33a5	0	10	f	\N	acbb2309-9313-477f-92bd-96cf9791a769
afaf62de-e243-400a-acd4-9b2428bdd8c6	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	18241412-db05-4a68-aab2-bb6d23cf33a5	0	20	t	c1b00abe-bb15-42b2-8914-ca8203b6253b	\N
09094301-39f2-4455-9d63-c3110b192996	\N	idp-create-user-if-unique	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c1b00abe-bb15-42b2-8914-ca8203b6253b	2	10	f	\N	b1bc0c3f-9f22-4b66-bf97-99001875c503
7372415b-78d1-4955-971b-12020e6bc88e	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c1b00abe-bb15-42b2-8914-ca8203b6253b	2	20	t	b0719b7d-b13d-4766-b3b2-5de2fe024271	\N
148fb7a8-d837-4fb6-925d-3df8442e6e61	\N	idp-confirm-link	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	b0719b7d-b13d-4766-b3b2-5de2fe024271	0	10	f	\N	\N
33dd2231-6ebb-418a-b4d2-9f3c6932a9ec	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	b0719b7d-b13d-4766-b3b2-5de2fe024271	0	20	t	dfd28f55-7b52-4080-8033-423dd98885e0	\N
d0e9358c-8da6-49fc-bad0-67282d3f4035	\N	idp-email-verification	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	dfd28f55-7b52-4080-8033-423dd98885e0	2	10	f	\N	\N
ea12dde3-14f7-4ccb-8c21-82c145b3e35d	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	dfd28f55-7b52-4080-8033-423dd98885e0	2	20	t	d91ef531-cbed-451e-ad90-fd6e2bd40b4e	\N
047359a2-1d63-4946-9750-77de04ad797b	\N	idp-username-password-form	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	d91ef531-cbed-451e-ad90-fd6e2bd40b4e	0	10	f	\N	\N
8c8c3070-cf50-4ea4-a08b-d80869c7f697	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	d91ef531-cbed-451e-ad90-fd6e2bd40b4e	1	20	t	7c06d08f-49bb-4e92-93b5-f0537f0efe7d	\N
645e104c-e3c7-41d2-97e6-d94a944b5836	\N	conditional-user-configured	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	7c06d08f-49bb-4e92-93b5-f0537f0efe7d	0	10	f	\N	\N
bc02588d-9633-43b2-8042-880f921d716a	\N	auth-otp-form	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	7c06d08f-49bb-4e92-93b5-f0537f0efe7d	0	20	f	\N	\N
1deacbb3-bbbf-4d43-86b1-36927ba44e71	\N	http-basic-authenticator	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	ac18c828-c3e4-44d8-aadb-b35bd6bb9fa0	0	10	f	\N	\N
a06980dc-faf8-41eb-bfef-a68ebd47feb0	\N	docker-http-basic-authenticator	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	cd8c6cbf-90b5-4b5e-bdfd-aca426a18277	0	10	f	\N	\N
063d863b-1cd8-42ea-ac0f-972b71cf913e	\N	idp-email-verification	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ed0b055f-deab-4f70-b5e3-222a597b7494	2	10	f	\N	\N
fe03c78f-7551-4329-943c-38e3df896579	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ed0b055f-deab-4f70-b5e3-222a597b7494	2	20	t	ffeba8fc-0511-4368-88ba-f26286bffd1d	\N
3457dfcf-4731-482e-a303-23a68fc0edcd	\N	conditional-user-configured	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	2f920bc2-7f0a-419a-9985-391bbbf15827	0	10	f	\N	\N
1bead002-3964-47f0-8d1a-f4d55f1bf40e	\N	auth-otp-form	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	2f920bc2-7f0a-419a-9985-391bbbf15827	0	20	f	\N	\N
e72c76ae-d315-41c7-b96c-c0ba63802dd3	\N	conditional-user-configured	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	8b1f8c62-7c55-41ef-b738-ea55edd30aca	0	10	f	\N	\N
eb1c296e-709e-4a47-a216-d06f877756ec	\N	direct-grant-validate-otp	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	8b1f8c62-7c55-41ef-b738-ea55edd30aca	0	20	f	\N	\N
c4f60402-4e7d-4827-bd6e-aca04c582897	\N	conditional-user-configured	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	d1bf1026-aeef-40e7-ae09-3a56c53cfb93	0	10	f	\N	\N
bb0a06a1-504e-4574-b3c9-06933470b466	\N	auth-otp-form	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	d1bf1026-aeef-40e7-ae09-3a56c53cfb93	0	20	f	\N	\N
67ed7d18-6016-436b-9739-64b3c5e42276	\N	idp-confirm-link	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	1192edce-f0ee-4234-a860-413ba213e41b	0	10	f	\N	\N
52cc9faa-a0e3-47ee-9fd6-0ee7b20a68ce	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	1192edce-f0ee-4234-a860-413ba213e41b	0	20	t	ed0b055f-deab-4f70-b5e3-222a597b7494	\N
e2511787-1c24-448d-afa9-f8e56e5fdcf5	\N	conditional-user-configured	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	59479800-0763-45a1-95dd-6d8b083fcabc	0	10	f	\N	\N
90b7c4f2-ccf2-4c57-8137-5f7f99779b1b	\N	reset-otp	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	59479800-0763-45a1-95dd-6d8b083fcabc	0	20	f	\N	\N
f4e5a310-640b-4561-86b0-1d36db4ecbe9	\N	idp-create-user-if-unique	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	53f34b7c-e229-4654-9497-a9aa90604b55	2	10	f	\N	c93179c4-cc3c-48b6-abdd-9933243aeefa
ab4ceadc-6bb2-40bb-9d2c-1840e0240b58	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	53f34b7c-e229-4654-9497-a9aa90604b55	2	20	t	1192edce-f0ee-4234-a860-413ba213e41b	\N
125b884b-4ad7-4a38-a379-fbfff7d827bb	\N	idp-username-password-form	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ffeba8fc-0511-4368-88ba-f26286bffd1d	0	10	f	\N	\N
039fdb65-7d4a-497c-84f4-ef7c83ddb527	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ffeba8fc-0511-4368-88ba-f26286bffd1d	1	20	t	d1bf1026-aeef-40e7-ae09-3a56c53cfb93	\N
871dd60a-35a8-4f56-be2b-a2ef053d8d86	\N	auth-cookie	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	7e098704-19e7-4ee6-88dd-8a2e05c2d39a	2	10	f	\N	\N
fc1e9aae-c42b-4313-9302-f0883c753a25	\N	auth-spnego	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	7e098704-19e7-4ee6-88dd-8a2e05c2d39a	3	20	f	\N	\N
293ae512-5a15-4e41-a34a-7dcea1d69a27	\N	identity-provider-redirector	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	7e098704-19e7-4ee6-88dd-8a2e05c2d39a	2	25	f	\N	\N
fa62c33b-59c9-4068-9d13-8ca00833b95c	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	7e098704-19e7-4ee6-88dd-8a2e05c2d39a	2	30	t	505350e3-096f-4b18-81fe-79a8e2ca3580	\N
ad678f67-0147-4bb5-9b6c-57fc393632f3	\N	client-secret	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	2cfcd5a0-00dd-43ed-b332-8be33756f879	2	10	f	\N	\N
1ab40d3c-71b6-493e-b1ed-d5864034cadd	\N	client-jwt	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	2cfcd5a0-00dd-43ed-b332-8be33756f879	2	20	f	\N	\N
cee26afc-06e4-4977-97d2-a9468efe862f	\N	client-secret-jwt	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	2cfcd5a0-00dd-43ed-b332-8be33756f879	2	30	f	\N	\N
a75b76d1-685a-444a-aa4a-09bf5bd305ec	\N	client-x509	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	2cfcd5a0-00dd-43ed-b332-8be33756f879	2	40	f	\N	\N
8bb32e9d-3b95-42d5-9e7b-f2fc7d627815	\N	direct-grant-validate-username	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	8dd0b2ed-976d-4f2b-8218-0d7028f6f016	0	10	f	\N	\N
55572193-2e3f-48c5-8028-c1707c63b56f	\N	direct-grant-validate-password	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	8dd0b2ed-976d-4f2b-8218-0d7028f6f016	0	20	f	\N	\N
1c2f1183-d3cc-4c1c-814c-f8cdc456cf9d	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	8dd0b2ed-976d-4f2b-8218-0d7028f6f016	1	30	t	8b1f8c62-7c55-41ef-b738-ea55edd30aca	\N
dcaa08b4-e173-4d59-b43a-93bb522b09b3	\N	docker-http-basic-authenticator	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	85e041ab-af74-4ef8-803d-591bc1c3559c	0	10	f	\N	\N
964a95e9-5ed7-448f-893d-86a852741317	\N	idp-review-profile	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	6c12061e-b841-4cea-8e0a-8aa3b520224f	0	10	f	\N	5d1ccbb5-ed65-4c24-ac54-670f549298f2
8e37c119-3aca-474d-ae31-679f3c87adb2	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	6c12061e-b841-4cea-8e0a-8aa3b520224f	0	20	t	53f34b7c-e229-4654-9497-a9aa90604b55	\N
cee1c9c3-a5aa-4fc2-9dd1-89822ab0acb7	\N	auth-username-password-form	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	505350e3-096f-4b18-81fe-79a8e2ca3580	0	10	f	\N	\N
c8c199d0-1b95-43b1-9ec8-a07aa4df5059	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	505350e3-096f-4b18-81fe-79a8e2ca3580	1	20	t	2f920bc2-7f0a-419a-9985-391bbbf15827	\N
ada0522c-2fb9-4b0f-b4a5-13aecb105d1f	\N	registration-page-form	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	59bd626e-fec5-4a2e-aeba-ce64f5aa40f3	0	10	t	eccd029f-d31e-4d6e-bdaa-2238c6b1dd04	\N
27ceaed3-5f9b-4c01-b13a-55ec496983bd	\N	registration-user-creation	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	eccd029f-d31e-4d6e-bdaa-2238c6b1dd04	0	20	f	\N	\N
dd9566fe-aa62-4838-be17-fc94a9f5cfd3	\N	registration-password-action	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	eccd029f-d31e-4d6e-bdaa-2238c6b1dd04	0	50	f	\N	\N
1cca0654-8a2d-4c54-b1d7-f6236ea20dd1	\N	registration-recaptcha-action	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	eccd029f-d31e-4d6e-bdaa-2238c6b1dd04	3	60	f	\N	\N
4013e4b3-355a-453f-b597-c7466f38104f	\N	registration-terms-and-conditions	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	eccd029f-d31e-4d6e-bdaa-2238c6b1dd04	3	70	f	\N	\N
6b34d94f-ac3e-4473-a965-986bfc5116a4	\N	reset-credentials-choose-user	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	08a5c0a4-d929-41f0-bf60-fbe30ccda13f	0	10	f	\N	\N
e07af388-7129-4c8d-af27-7c4dc6bf3534	\N	reset-credential-email	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	08a5c0a4-d929-41f0-bf60-fbe30ccda13f	0	20	f	\N	\N
5c7e8c5a-0c5d-46b2-acca-6320568e9e6f	\N	reset-password	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	08a5c0a4-d929-41f0-bf60-fbe30ccda13f	0	30	f	\N	\N
d670746e-a32a-4f1a-a847-2fc2c3611fd1	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	08a5c0a4-d929-41f0-bf60-fbe30ccda13f	1	40	t	59479800-0763-45a1-95dd-6d8b083fcabc	\N
afef82ed-74d7-4200-aed0-36aa0686d6f2	\N	http-basic-authenticator	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	010fc2f6-abaa-4d92-9304-7c51d0d36321	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
88716f92-a2cf-4f1a-a4d3-fe1dc865674d	browser	browser based authentication	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	t	t
fb84776f-4fc8-4d91-9442-fd8a95936a34	forms	Username, password, otp and other auth forms.	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
a05f1f08-6937-4466-9975-294fe8596703	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
ca8ad2ec-1f2b-43f2-aa49-ab209f8024ab	direct grant	OpenID Connect Resource Owner Grant	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	t	t
f278190a-35d9-444f-9e96-bfba81ff7495	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
21243c6b-3795-4407-9f11-f3cd990a789b	registration	registration flow	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	t	t
a7ab2c67-709b-426f-ae26-770ef5237be1	registration form	registration form	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	form-flow	f	t
8957ed4b-6b0f-4185-9e60-464182460515	reset credentials	Reset credentials for a user if they forgot their password or something	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	t	t
f414df51-10c6-460e-97d5-bab46d5ada61	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
fbecc78b-5ecb-4911-b6d3-7d245c525bf4	clients	Base authentication for clients	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	client-flow	t	t
18241412-db05-4a68-aab2-bb6d23cf33a5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	t	t
c1b00abe-bb15-42b2-8914-ca8203b6253b	User creation or linking	Flow for the existing/non-existing user alternatives	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
b0719b7d-b13d-4766-b3b2-5de2fe024271	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
dfd28f55-7b52-4080-8033-423dd98885e0	Account verification options	Method with which to verity the existing account	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
d91ef531-cbed-451e-ad90-fd6e2bd40b4e	Verify Existing Account by Re-authentication	Reauthentication of existing account	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
7c06d08f-49bb-4e92-93b5-f0537f0efe7d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	f	t
ac18c828-c3e4-44d8-aadb-b35bd6bb9fa0	saml ecp	SAML ECP Profile Authentication Flow	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	t	t
cd8c6cbf-90b5-4b5e-bdfd-aca426a18277	docker auth	Used by Docker clients to authenticate against the IDP	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	basic-flow	t	t
ed0b055f-deab-4f70-b5e3-222a597b7494	Account verification options	Method with which to verity the existing account	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
2f920bc2-7f0a-419a-9985-391bbbf15827	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
8b1f8c62-7c55-41ef-b738-ea55edd30aca	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
d1bf1026-aeef-40e7-ae09-3a56c53cfb93	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
1192edce-f0ee-4234-a860-413ba213e41b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
59479800-0763-45a1-95dd-6d8b083fcabc	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
53f34b7c-e229-4654-9497-a9aa90604b55	User creation or linking	Flow for the existing/non-existing user alternatives	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
ffeba8fc-0511-4368-88ba-f26286bffd1d	Verify Existing Account by Re-authentication	Reauthentication of existing account	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
7e098704-19e7-4ee6-88dd-8a2e05c2d39a	browser	browser based authentication	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	t	t
2cfcd5a0-00dd-43ed-b332-8be33756f879	clients	Base authentication for clients	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	client-flow	t	t
8dd0b2ed-976d-4f2b-8218-0d7028f6f016	direct grant	OpenID Connect Resource Owner Grant	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	t	t
85e041ab-af74-4ef8-803d-591bc1c3559c	docker auth	Used by Docker clients to authenticate against the IDP	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	t	t
6c12061e-b841-4cea-8e0a-8aa3b520224f	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	t	t
505350e3-096f-4b18-81fe-79a8e2ca3580	forms	Username, password, otp and other auth forms.	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	f	t
59bd626e-fec5-4a2e-aeba-ce64f5aa40f3	registration	registration flow	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	t	t
eccd029f-d31e-4d6e-bdaa-2238c6b1dd04	registration form	registration form	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	form-flow	f	t
08a5c0a4-d929-41f0-bf60-fbe30ccda13f	reset credentials	Reset credentials for a user if they forgot their password or something	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	t	t
010fc2f6-abaa-4d92-9304-7c51d0d36321	saml ecp	SAML ECP Profile Authentication Flow	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
acbb2309-9313-477f-92bd-96cf9791a769	review profile config	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b
b1bc0c3f-9f22-4b66-bf97-99001875c503	create unique user config	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b
c93179c4-cc3c-48b6-abdd-9933243aeefa	create unique user config	0ad55232-77dd-4fe6-bfc7-31fe24e318ad
5d1ccbb5-ed65-4c24-ac54-670f549298f2	review profile config	0ad55232-77dd-4fe6-bfc7-31fe24e318ad
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
acbb2309-9313-477f-92bd-96cf9791a769	missing	update.profile.on.first.login
b1bc0c3f-9f22-4b66-bf97-99001875c503	false	require.password.update.after.registration
5d1ccbb5-ed65-4c24-ac54-670f549298f2	missing	update.profile.on.first.login
c93179c4-cc3c-48b6-abdd-9933243aeefa	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
179a09f5-5f12-4ab7-812a-d47bb60745e4	t	f	master-realm	0	f	\N	\N	t	\N	f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
c86c3790-9634-4fed-8575-f55be03be359	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b55ec150-c0bd-4171-b469-a65da147094d	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
52908a2c-56fc-46ed-a6a0-7043745ff784	t	f	broker	0	f	\N	\N	t	\N	f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
26ee6233-697d-43ff-bac9-31f7d2fce25f	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9c749761-1613-4a50-bdc0-4c0e6c5f909c	t	f	admin-cli	0	t	\N	\N	f	\N	f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
29501232-33d4-45e4-b842-cd8ef4557d02	t	f	account	0	t	\N	/realms/RH-Realm/account/	f	\N	f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	t	f	account-console	0	t	\N	/realms/RH-Realm/account/	f		f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}		\N	t	f	f	f
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	t	f	admin-cli	0	t	\N	\N	f	\N	f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
2c372afa-e895-493e-b75f-55bea5c0c2c9	t	f	broker	0	f	\N	\N	t	\N	f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
151aede7-bfd9-481c-a55a-63cd79d17dbb	t	t	keycloak-admin	0	f	6Sj9xauDxSpoBCfHXHjp12SsuMqzyOHt		f		f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	-1	t	f	Keycloak Admin Client	t	client-secret			\N	t	f	t	f
566f5d77-b470-4cc8-94c9-8e735428c1a3	t	f	realm-management	0	f	\N	\N	t		f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N		\N	t	f	f	f
6cea6109-8f92-4041-8ccd-42c817d35904	t	f	RH-Realm-realm	0	f	\N	\N	t	\N	f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N	0	f	f	RH-Realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
19544a21-ea96-4619-9ce7-1eda3cd043c6	t	t	rh	0	t	\N		f	http://localhost:4200	f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	-1	t	f	rh	f	client-secret	http://localhost:4200		\N	t	f	t	f
bf492b87-578b-4fde-b9bf-29832f852159	t	f	security-admin-console	0	t	\N	/admin/RH-Realm/console/	f	\N	f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
c86c3790-9634-4fed-8575-f55be03be359	post.logout.redirect.uris	+
b55ec150-c0bd-4171-b469-a65da147094d	post.logout.redirect.uris	+
b55ec150-c0bd-4171-b469-a65da147094d	pkce.code.challenge.method	S256
26ee6233-697d-43ff-bac9-31f7d2fce25f	post.logout.redirect.uris	+
26ee6233-697d-43ff-bac9-31f7d2fce25f	pkce.code.challenge.method	S256
29501232-33d4-45e4-b842-cd8ef4557d02	post.logout.redirect.uris	+
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	oidc.ciba.grant.enabled	false
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	backchannel.logout.session.required	true
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	post.logout.redirect.uris	+
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	display.on.consent.screen	false
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	oauth2.device.authorization.grant.enabled	false
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	pkce.code.challenge.method	S256
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	backchannel.logout.revoke.offline.tokens	false
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	post.logout.redirect.uris	+
2c372afa-e895-493e-b75f-55bea5c0c2c9	post.logout.redirect.uris	+
151aede7-bfd9-481c-a55a-63cd79d17dbb	oidc.ciba.grant.enabled	false
151aede7-bfd9-481c-a55a-63cd79d17dbb	client.secret.creation.time	1743461917
151aede7-bfd9-481c-a55a-63cd79d17dbb	backchannel.logout.session.required	true
151aede7-bfd9-481c-a55a-63cd79d17dbb	display.on.consent.screen	false
151aede7-bfd9-481c-a55a-63cd79d17dbb	oauth2.device.authorization.grant.enabled	false
151aede7-bfd9-481c-a55a-63cd79d17dbb	backchannel.logout.revoke.offline.tokens	false
151aede7-bfd9-481c-a55a-63cd79d17dbb	post.logout.redirect.uris	+
566f5d77-b470-4cc8-94c9-8e735428c1a3	post.logout.redirect.uris	+
19544a21-ea96-4619-9ce7-1eda3cd043c6	oidc.ciba.grant.enabled	false
19544a21-ea96-4619-9ce7-1eda3cd043c6	client.secret.creation.time	1743609620
19544a21-ea96-4619-9ce7-1eda3cd043c6	backchannel.logout.session.required	true
19544a21-ea96-4619-9ce7-1eda3cd043c6	post.logout.redirect.uris	http://localhost:4200/*
19544a21-ea96-4619-9ce7-1eda3cd043c6	display.on.consent.screen	false
19544a21-ea96-4619-9ce7-1eda3cd043c6	oauth2.device.authorization.grant.enabled	false
19544a21-ea96-4619-9ce7-1eda3cd043c6	backchannel.logout.revoke.offline.tokens	false
bf492b87-578b-4fde-b9bf-29832f852159	post.logout.redirect.uris	+
bf492b87-578b-4fde-b9bf-29832f852159	pkce.code.challenge.method	S256
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
78836fe5-2a85-4dd8-8c52-da0f45ae4619	offline_access	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect built-in scope: offline_access	openid-connect
a0a3bf93-c4ca-4a00-80f9-6642981d3e74	role_list	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	SAML role list	saml
811805e9-cdde-4870-89ae-449e5e89484b	profile	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect built-in scope: profile	openid-connect
4e11996f-7d98-4b69-8edf-09663ca91a7a	email	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect built-in scope: email	openid-connect
62995ff6-6461-4085-96b1-99a3c3689979	address	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect built-in scope: address	openid-connect
f8948f94-547a-4ac0-9b28-ce00350f0e13	phone	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect built-in scope: phone	openid-connect
6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	roles	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect scope for add user roles to the access token	openid-connect
5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	web-origins	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
8738ba8a-84fd-428c-839b-b7ee9319fb8c	microprofile-jwt	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	Microprofile - JWT built-in scope	openid-connect
1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	acr	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ce2b093b-daf0-4445-8a41-6301b92b85c8	email	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect built-in scope: email	openid-connect
916fed05-4033-4a33-b05d-4294e47dc5ae	profile	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect built-in scope: profile	openid-connect
c8cadcf1-3648-4655-b501-b8535c2e43dc	phone	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect built-in scope: phone	openid-connect
6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	acr	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
0bccc420-0d97-4cd3-875c-585e1ca6cfc3	web-origins	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3096f6ee-cc4b-4bb4-8330-888c1197403f	address	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect built-in scope: address	openid-connect
1f624268-80e0-4624-b8d6-d8621b0356ce	microprofile-jwt	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	Microprofile - JWT built-in scope	openid-connect
76eb7e14-0736-46bd-a947-4d357ca06174	roles	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect scope for add user roles to the access token	openid-connect
68b428cd-fe52-43b1-8588-f5bf2a37772b	offline_access	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	OpenID Connect built-in scope: offline_access	openid-connect
5c0abf3d-f2cd-4b86-9dfa-8d5c16f29e12	role_list	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	SAML role list	saml
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
78836fe5-2a85-4dd8-8c52-da0f45ae4619	true	display.on.consent.screen
78836fe5-2a85-4dd8-8c52-da0f45ae4619	${offlineAccessScopeConsentText}	consent.screen.text
a0a3bf93-c4ca-4a00-80f9-6642981d3e74	true	display.on.consent.screen
a0a3bf93-c4ca-4a00-80f9-6642981d3e74	${samlRoleListScopeConsentText}	consent.screen.text
811805e9-cdde-4870-89ae-449e5e89484b	true	display.on.consent.screen
811805e9-cdde-4870-89ae-449e5e89484b	${profileScopeConsentText}	consent.screen.text
811805e9-cdde-4870-89ae-449e5e89484b	true	include.in.token.scope
4e11996f-7d98-4b69-8edf-09663ca91a7a	true	display.on.consent.screen
4e11996f-7d98-4b69-8edf-09663ca91a7a	${emailScopeConsentText}	consent.screen.text
4e11996f-7d98-4b69-8edf-09663ca91a7a	true	include.in.token.scope
62995ff6-6461-4085-96b1-99a3c3689979	true	display.on.consent.screen
62995ff6-6461-4085-96b1-99a3c3689979	${addressScopeConsentText}	consent.screen.text
62995ff6-6461-4085-96b1-99a3c3689979	true	include.in.token.scope
f8948f94-547a-4ac0-9b28-ce00350f0e13	true	display.on.consent.screen
f8948f94-547a-4ac0-9b28-ce00350f0e13	${phoneScopeConsentText}	consent.screen.text
f8948f94-547a-4ac0-9b28-ce00350f0e13	true	include.in.token.scope
6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	true	display.on.consent.screen
6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	${rolesScopeConsentText}	consent.screen.text
6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	false	include.in.token.scope
5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	false	display.on.consent.screen
5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c		consent.screen.text
5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	false	include.in.token.scope
8738ba8a-84fd-428c-839b-b7ee9319fb8c	false	display.on.consent.screen
8738ba8a-84fd-428c-839b-b7ee9319fb8c	true	include.in.token.scope
1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	false	display.on.consent.screen
1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	false	include.in.token.scope
6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	false	include.in.token.scope
6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	false	display.on.consent.screen
0bccc420-0d97-4cd3-875c-585e1ca6cfc3	false	include.in.token.scope
0bccc420-0d97-4cd3-875c-585e1ca6cfc3	false	display.on.consent.screen
0bccc420-0d97-4cd3-875c-585e1ca6cfc3		consent.screen.text
3096f6ee-cc4b-4bb4-8330-888c1197403f	true	include.in.token.scope
3096f6ee-cc4b-4bb4-8330-888c1197403f	true	display.on.consent.screen
3096f6ee-cc4b-4bb4-8330-888c1197403f	${addressScopeConsentText}	consent.screen.text
1f624268-80e0-4624-b8d6-d8621b0356ce	true	include.in.token.scope
1f624268-80e0-4624-b8d6-d8621b0356ce	false	display.on.consent.screen
76eb7e14-0736-46bd-a947-4d357ca06174	false	include.in.token.scope
76eb7e14-0736-46bd-a947-4d357ca06174	true	display.on.consent.screen
76eb7e14-0736-46bd-a947-4d357ca06174	${rolesScopeConsentText}	consent.screen.text
68b428cd-fe52-43b1-8588-f5bf2a37772b	${offlineAccessScopeConsentText}	consent.screen.text
68b428cd-fe52-43b1-8588-f5bf2a37772b	true	display.on.consent.screen
5c0abf3d-f2cd-4b86-9dfa-8d5c16f29e12	${samlRoleListScopeConsentText}	consent.screen.text
5c0abf3d-f2cd-4b86-9dfa-8d5c16f29e12	true	display.on.consent.screen
ce2b093b-daf0-4445-8a41-6301b92b85c8	true	include.in.token.scope
ce2b093b-daf0-4445-8a41-6301b92b85c8	true	display.on.consent.screen
ce2b093b-daf0-4445-8a41-6301b92b85c8	${emailScopeConsentText}	consent.screen.text
916fed05-4033-4a33-b05d-4294e47dc5ae	true	include.in.token.scope
916fed05-4033-4a33-b05d-4294e47dc5ae	true	display.on.consent.screen
916fed05-4033-4a33-b05d-4294e47dc5ae	${profileScopeConsentText}	consent.screen.text
c8cadcf1-3648-4655-b501-b8535c2e43dc	true	include.in.token.scope
c8cadcf1-3648-4655-b501-b8535c2e43dc	true	display.on.consent.screen
c8cadcf1-3648-4655-b501-b8535c2e43dc	${phoneScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
c86c3790-9634-4fed-8575-f55be03be359	811805e9-cdde-4870-89ae-449e5e89484b	t
c86c3790-9634-4fed-8575-f55be03be359	4e11996f-7d98-4b69-8edf-09663ca91a7a	t
c86c3790-9634-4fed-8575-f55be03be359	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	t
c86c3790-9634-4fed-8575-f55be03be359	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	t
c86c3790-9634-4fed-8575-f55be03be359	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	t
c86c3790-9634-4fed-8575-f55be03be359	f8948f94-547a-4ac0-9b28-ce00350f0e13	f
c86c3790-9634-4fed-8575-f55be03be359	78836fe5-2a85-4dd8-8c52-da0f45ae4619	f
c86c3790-9634-4fed-8575-f55be03be359	62995ff6-6461-4085-96b1-99a3c3689979	f
c86c3790-9634-4fed-8575-f55be03be359	8738ba8a-84fd-428c-839b-b7ee9319fb8c	f
b55ec150-c0bd-4171-b469-a65da147094d	811805e9-cdde-4870-89ae-449e5e89484b	t
b55ec150-c0bd-4171-b469-a65da147094d	4e11996f-7d98-4b69-8edf-09663ca91a7a	t
b55ec150-c0bd-4171-b469-a65da147094d	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	t
b55ec150-c0bd-4171-b469-a65da147094d	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	t
b55ec150-c0bd-4171-b469-a65da147094d	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	t
b55ec150-c0bd-4171-b469-a65da147094d	f8948f94-547a-4ac0-9b28-ce00350f0e13	f
b55ec150-c0bd-4171-b469-a65da147094d	78836fe5-2a85-4dd8-8c52-da0f45ae4619	f
b55ec150-c0bd-4171-b469-a65da147094d	62995ff6-6461-4085-96b1-99a3c3689979	f
b55ec150-c0bd-4171-b469-a65da147094d	8738ba8a-84fd-428c-839b-b7ee9319fb8c	f
9c749761-1613-4a50-bdc0-4c0e6c5f909c	811805e9-cdde-4870-89ae-449e5e89484b	t
9c749761-1613-4a50-bdc0-4c0e6c5f909c	4e11996f-7d98-4b69-8edf-09663ca91a7a	t
9c749761-1613-4a50-bdc0-4c0e6c5f909c	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	t
9c749761-1613-4a50-bdc0-4c0e6c5f909c	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	t
9c749761-1613-4a50-bdc0-4c0e6c5f909c	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	t
9c749761-1613-4a50-bdc0-4c0e6c5f909c	f8948f94-547a-4ac0-9b28-ce00350f0e13	f
9c749761-1613-4a50-bdc0-4c0e6c5f909c	78836fe5-2a85-4dd8-8c52-da0f45ae4619	f
9c749761-1613-4a50-bdc0-4c0e6c5f909c	62995ff6-6461-4085-96b1-99a3c3689979	f
9c749761-1613-4a50-bdc0-4c0e6c5f909c	8738ba8a-84fd-428c-839b-b7ee9319fb8c	f
52908a2c-56fc-46ed-a6a0-7043745ff784	811805e9-cdde-4870-89ae-449e5e89484b	t
52908a2c-56fc-46ed-a6a0-7043745ff784	4e11996f-7d98-4b69-8edf-09663ca91a7a	t
52908a2c-56fc-46ed-a6a0-7043745ff784	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	t
52908a2c-56fc-46ed-a6a0-7043745ff784	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	t
52908a2c-56fc-46ed-a6a0-7043745ff784	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	t
52908a2c-56fc-46ed-a6a0-7043745ff784	f8948f94-547a-4ac0-9b28-ce00350f0e13	f
52908a2c-56fc-46ed-a6a0-7043745ff784	78836fe5-2a85-4dd8-8c52-da0f45ae4619	f
52908a2c-56fc-46ed-a6a0-7043745ff784	62995ff6-6461-4085-96b1-99a3c3689979	f
52908a2c-56fc-46ed-a6a0-7043745ff784	8738ba8a-84fd-428c-839b-b7ee9319fb8c	f
179a09f5-5f12-4ab7-812a-d47bb60745e4	811805e9-cdde-4870-89ae-449e5e89484b	t
179a09f5-5f12-4ab7-812a-d47bb60745e4	4e11996f-7d98-4b69-8edf-09663ca91a7a	t
179a09f5-5f12-4ab7-812a-d47bb60745e4	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	t
179a09f5-5f12-4ab7-812a-d47bb60745e4	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	t
179a09f5-5f12-4ab7-812a-d47bb60745e4	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	t
179a09f5-5f12-4ab7-812a-d47bb60745e4	f8948f94-547a-4ac0-9b28-ce00350f0e13	f
179a09f5-5f12-4ab7-812a-d47bb60745e4	78836fe5-2a85-4dd8-8c52-da0f45ae4619	f
179a09f5-5f12-4ab7-812a-d47bb60745e4	62995ff6-6461-4085-96b1-99a3c3689979	f
179a09f5-5f12-4ab7-812a-d47bb60745e4	8738ba8a-84fd-428c-839b-b7ee9319fb8c	f
26ee6233-697d-43ff-bac9-31f7d2fce25f	811805e9-cdde-4870-89ae-449e5e89484b	t
26ee6233-697d-43ff-bac9-31f7d2fce25f	4e11996f-7d98-4b69-8edf-09663ca91a7a	t
26ee6233-697d-43ff-bac9-31f7d2fce25f	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	t
26ee6233-697d-43ff-bac9-31f7d2fce25f	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	t
26ee6233-697d-43ff-bac9-31f7d2fce25f	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	t
26ee6233-697d-43ff-bac9-31f7d2fce25f	f8948f94-547a-4ac0-9b28-ce00350f0e13	f
26ee6233-697d-43ff-bac9-31f7d2fce25f	78836fe5-2a85-4dd8-8c52-da0f45ae4619	f
26ee6233-697d-43ff-bac9-31f7d2fce25f	62995ff6-6461-4085-96b1-99a3c3689979	f
26ee6233-697d-43ff-bac9-31f7d2fce25f	8738ba8a-84fd-428c-839b-b7ee9319fb8c	f
29501232-33d4-45e4-b842-cd8ef4557d02	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
29501232-33d4-45e4-b842-cd8ef4557d02	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
29501232-33d4-45e4-b842-cd8ef4557d02	76eb7e14-0736-46bd-a947-4d357ca06174	t
29501232-33d4-45e4-b842-cd8ef4557d02	916fed05-4033-4a33-b05d-4294e47dc5ae	t
29501232-33d4-45e4-b842-cd8ef4557d02	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
29501232-33d4-45e4-b842-cd8ef4557d02	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
29501232-33d4-45e4-b842-cd8ef4557d02	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
29501232-33d4-45e4-b842-cd8ef4557d02	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
29501232-33d4-45e4-b842-cd8ef4557d02	1f624268-80e0-4624-b8d6-d8621b0356ce	f
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	76eb7e14-0736-46bd-a947-4d357ca06174	t
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	916fed05-4033-4a33-b05d-4294e47dc5ae	t
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	1f624268-80e0-4624-b8d6-d8621b0356ce	f
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	76eb7e14-0736-46bd-a947-4d357ca06174	t
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	916fed05-4033-4a33-b05d-4294e47dc5ae	t
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
6fd3cae3-b85d-4ae4-bb37-5cf905b0cae0	1f624268-80e0-4624-b8d6-d8621b0356ce	f
2c372afa-e895-493e-b75f-55bea5c0c2c9	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
2c372afa-e895-493e-b75f-55bea5c0c2c9	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
2c372afa-e895-493e-b75f-55bea5c0c2c9	76eb7e14-0736-46bd-a947-4d357ca06174	t
2c372afa-e895-493e-b75f-55bea5c0c2c9	916fed05-4033-4a33-b05d-4294e47dc5ae	t
2c372afa-e895-493e-b75f-55bea5c0c2c9	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
2c372afa-e895-493e-b75f-55bea5c0c2c9	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
2c372afa-e895-493e-b75f-55bea5c0c2c9	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
2c372afa-e895-493e-b75f-55bea5c0c2c9	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
2c372afa-e895-493e-b75f-55bea5c0c2c9	1f624268-80e0-4624-b8d6-d8621b0356ce	f
151aede7-bfd9-481c-a55a-63cd79d17dbb	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
151aede7-bfd9-481c-a55a-63cd79d17dbb	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
151aede7-bfd9-481c-a55a-63cd79d17dbb	76eb7e14-0736-46bd-a947-4d357ca06174	t
151aede7-bfd9-481c-a55a-63cd79d17dbb	916fed05-4033-4a33-b05d-4294e47dc5ae	t
151aede7-bfd9-481c-a55a-63cd79d17dbb	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
151aede7-bfd9-481c-a55a-63cd79d17dbb	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
151aede7-bfd9-481c-a55a-63cd79d17dbb	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
151aede7-bfd9-481c-a55a-63cd79d17dbb	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
151aede7-bfd9-481c-a55a-63cd79d17dbb	1f624268-80e0-4624-b8d6-d8621b0356ce	f
566f5d77-b470-4cc8-94c9-8e735428c1a3	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
566f5d77-b470-4cc8-94c9-8e735428c1a3	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
566f5d77-b470-4cc8-94c9-8e735428c1a3	76eb7e14-0736-46bd-a947-4d357ca06174	t
566f5d77-b470-4cc8-94c9-8e735428c1a3	916fed05-4033-4a33-b05d-4294e47dc5ae	t
566f5d77-b470-4cc8-94c9-8e735428c1a3	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
566f5d77-b470-4cc8-94c9-8e735428c1a3	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
566f5d77-b470-4cc8-94c9-8e735428c1a3	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
566f5d77-b470-4cc8-94c9-8e735428c1a3	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
566f5d77-b470-4cc8-94c9-8e735428c1a3	1f624268-80e0-4624-b8d6-d8621b0356ce	f
19544a21-ea96-4619-9ce7-1eda3cd043c6	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
19544a21-ea96-4619-9ce7-1eda3cd043c6	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
19544a21-ea96-4619-9ce7-1eda3cd043c6	76eb7e14-0736-46bd-a947-4d357ca06174	t
19544a21-ea96-4619-9ce7-1eda3cd043c6	916fed05-4033-4a33-b05d-4294e47dc5ae	t
19544a21-ea96-4619-9ce7-1eda3cd043c6	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
19544a21-ea96-4619-9ce7-1eda3cd043c6	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
19544a21-ea96-4619-9ce7-1eda3cd043c6	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
19544a21-ea96-4619-9ce7-1eda3cd043c6	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
19544a21-ea96-4619-9ce7-1eda3cd043c6	1f624268-80e0-4624-b8d6-d8621b0356ce	f
bf492b87-578b-4fde-b9bf-29832f852159	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
bf492b87-578b-4fde-b9bf-29832f852159	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
bf492b87-578b-4fde-b9bf-29832f852159	76eb7e14-0736-46bd-a947-4d357ca06174	t
bf492b87-578b-4fde-b9bf-29832f852159	916fed05-4033-4a33-b05d-4294e47dc5ae	t
bf492b87-578b-4fde-b9bf-29832f852159	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
bf492b87-578b-4fde-b9bf-29832f852159	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
bf492b87-578b-4fde-b9bf-29832f852159	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
bf492b87-578b-4fde-b9bf-29832f852159	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
bf492b87-578b-4fde-b9bf-29832f852159	1f624268-80e0-4624-b8d6-d8621b0356ce	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
78836fe5-2a85-4dd8-8c52-da0f45ae4619	e3c526f4-1b7c-43a0-a3e6-4b27325fc16f
68b428cd-fe52-43b1-8588-f5bf2a37772b	001e2cd6-f8e8-4eb4-8e2f-6f4376120db7
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
c4475e59-8006-45b0-ae8b-610724090f0a	Trusted Hosts	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	anonymous
073b90c0-384f-4e4d-be5f-ca5c57f11580	Consent Required	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	anonymous
6fff1e8e-0086-4c0c-90bb-7a5b96d72c43	Full Scope Disabled	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	anonymous
2bf9236c-651d-4123-a6a9-f9f56658c1a4	Max Clients Limit	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	anonymous
90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	Allowed Protocol Mapper Types	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	anonymous
f61f0b62-f956-4949-b295-06713cb389e3	Allowed Client Scopes	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	anonymous
88e6c7be-b1cd-47e1-bb00-5653e0e1b938	Allowed Protocol Mapper Types	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	authenticated
2a6aa5bc-3d37-4e79-9e4e-80ed14eb45c8	Allowed Client Scopes	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	authenticated
b0c415d0-1c9a-4ca8-bdda-7bdd337ad1f7	rsa-generated	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	rsa-generated	org.keycloak.keys.KeyProvider	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N
96330562-e1e0-409e-ad42-dfe6f93ae1b2	rsa-enc-generated	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	rsa-enc-generated	org.keycloak.keys.KeyProvider	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N
d2247285-7b9c-4f14-a796-ec0596a4e0ee	hmac-generated-hs512	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	hmac-generated	org.keycloak.keys.KeyProvider	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N
fdd3d9d9-c146-41c7-a501-92e34c288cab	aes-generated	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	aes-generated	org.keycloak.keys.KeyProvider	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N
890974e5-5448-4c86-96cc-52a677ad89b9	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N
1523e044-3f0f-4fe6-9d30-81b754f151d0	Allowed Client Scopes	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	anonymous
db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	Allowed Protocol Mapper Types	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	authenticated
052afa55-a853-49d9-92f2-9144a55cd920	Full Scope Disabled	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	anonymous
3dabe2a2-261c-4f64-9fe6-a78c6e53f35a	Allowed Client Scopes	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	authenticated
affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	Allowed Protocol Mapper Types	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	anonymous
3dd19d14-b90e-42f1-97cc-ec1190f5aeb6	Max Clients Limit	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	anonymous
e84bf758-f088-4e0c-81fd-7de4b6fcd8a8	Consent Required	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	anonymous
2e142c4f-430a-468d-96d7-59f10d4a4614	Trusted Hosts	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	anonymous
f0619eed-0ff7-4f80-bac6-379cc1b13e14	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N
db2abdfe-3238-4e99-b675-626db5bead4e	aes-generated	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	aes-generated	org.keycloak.keys.KeyProvider	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N
c07a4b5a-6505-4da5-aba8-b912beea9ec8	hmac-generated-hs512	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	hmac-generated	org.keycloak.keys.KeyProvider	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N
3ec0bc93-fdcd-4b65-89a8-9d863c57bd07	rsa-generated	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	rsa-generated	org.keycloak.keys.KeyProvider	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N
f87d7840-58ad-4713-bbaf-325b6c18b002	rsa-enc-generated	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	rsa-enc-generated	org.keycloak.keys.KeyProvider	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
42cc31c7-824e-460a-855f-7884ec1ec3df	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1fe515c5-aab2-4303-b846-3cc26dce7b5e	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
09ce96d7-d263-45e7-901d-2777a790b07e	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	saml-user-attribute-mapper
eb79a4f8-ad74-4a03-a673-93168d5a11be	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
fd526329-5874-4c8d-bd94-e9ab383dbcc5	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	saml-user-property-mapper
594777dc-91e9-43eb-977b-e6995f272530	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	oidc-full-name-mapper
93e66fbc-52fd-4d62-98b7-515f5bfbcff6	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	oidc-address-mapper
9f2b17b4-535e-4f0f-924b-135c6e92c097	90f4bdd9-4267-4c2f-8ef8-f6e7468fff90	allowed-protocol-mapper-types	saml-role-list-mapper
a7634e74-52a7-426a-8434-7d3d1a090164	c4475e59-8006-45b0-ae8b-610724090f0a	host-sending-registration-request-must-match	true
3f1a3182-9b33-4528-9190-99dee77015ee	c4475e59-8006-45b0-ae8b-610724090f0a	client-uris-must-match	true
00df9283-d09f-43d8-9bb3-10f071176a29	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	saml-user-property-mapper
88a5ce78-c9ba-49e2-84a7-1238ca5ad301	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	saml-role-list-mapper
efdf8323-fc41-464b-8e89-211b550655f2	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
222ac984-c96d-4353-8a2a-9ddfed369f97	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	saml-user-attribute-mapper
29723b2b-8c26-4119-b55a-cddb7e3b208f	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	oidc-address-mapper
fdf2bfee-88f6-4b9c-9807-5dbe88f530fb	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	oidc-full-name-mapper
415f81c8-f3e7-452e-aa12-d650050ceff2	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
aa0bb2e0-e88f-4b37-8db5-8eff418c1f10	88e6c7be-b1cd-47e1-bb00-5653e0e1b938	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
84cf533c-a180-475b-9b0d-113e801fcf66	2bf9236c-651d-4123-a6a9-f9f56658c1a4	max-clients	200
19554e0f-b577-4481-b530-d0b612bde724	2a6aa5bc-3d37-4e79-9e4e-80ed14eb45c8	allow-default-scopes	true
8fb6b280-ea15-4fff-a1dc-f722490214e8	f61f0b62-f956-4949-b295-06713cb389e3	allow-default-scopes	true
9416c3e0-8944-4a25-a13f-6d44c3a17e83	d2247285-7b9c-4f14-a796-ec0596a4e0ee	secret	mCR4T5uMlBFcXGSJsUTAPYz3Xo5o7VQhdc_LW0BtZlTJ5hTc12sWMKDlsaZY3LrrgvhMj8IyCkcqa-YeLztoSErcrziNNJeaIsPYqsawVb11CPcEF0m4bWqLhT8lB4sAQF-a_EHSQ3HUhWgsXWfTtR0McizOJRf4mNFjN9rkCfY
fe4069cc-7224-4fe0-a1a6-1e1e66b1ea11	d2247285-7b9c-4f14-a796-ec0596a4e0ee	algorithm	HS512
9b8dc9af-9193-4fef-8894-2920fb4edf70	d2247285-7b9c-4f14-a796-ec0596a4e0ee	kid	8be15980-879c-4a63-8c87-f8cfa2d057bf
44a52f97-f5aa-40da-99be-568b9413aeb7	d2247285-7b9c-4f14-a796-ec0596a4e0ee	priority	100
903e52c3-cc0b-447e-a1cb-b7071182db8f	fdd3d9d9-c146-41c7-a501-92e34c288cab	priority	100
6de9d7fe-4ff9-48b0-bbcc-5299f9c91ac8	fdd3d9d9-c146-41c7-a501-92e34c288cab	kid	beb51d77-2035-4e94-b1ea-4e40d3e1bb76
35a75776-5038-40d4-80ed-3b4287e74270	fdd3d9d9-c146-41c7-a501-92e34c288cab	secret	fZBvWcqnVfrTnoG9ePo2Tw
8d197930-b238-4ea2-8c09-91066da0c927	96330562-e1e0-409e-ad42-dfe6f93ae1b2	algorithm	RSA-OAEP
6aeca3e0-36de-46c4-93eb-24eecc935dc2	96330562-e1e0-409e-ad42-dfe6f93ae1b2	privateKey	MIIEogIBAAKCAQEApjbPJ4fHItEmTUcCkIdu5MtpbvYwzISrfUxD8RXCsVKSuTGSLFZCCijcBmWgQMGqFHRnJ7zaHkigOWD2ayDg93L8/W/7RAxmTinnrngcOsJ2HLTWFLJqXU7x0f7jy/0i1oAs3POCRX1aRqd5mFvZMdW9r9f1b2EVzdzLAEI0ENR6M5hDQhuz+rIT2w0jxGT0UmK8c7v3/3WM//GvU/oXA00MiWrdGs0BUIBIXZGah6TNyfLd6YnQmxKn6Zc/G6MLhg582fjDK0SUe6SVc3DBrt1CcjTmrbKo6aJ6Jc98l2e020IfWPV2ImgOWNFldxfn82ua6XSY61AsEVgpf8prVwIDAQABAoIBADOkT9SOYRa2ONpFt8xD5/Z6JLXvE9ZXWhjB+1IKWsVRTHjxp+LSog4aB9KM/K9h/IACcpJsILDMC8wIDkfWnU8EkQoFIuJPn/GlH3CbrNms1ZmxrdocXOPExWljck9MxOg0RrwXhGAmxEezfRoTX3YWXKsnw//pACdH9GKOLzMS8P3Z/kGTf39Fka8RzYW2bNB3FiYejY5etx1ZTb0FXkvz5j5vauKP+yGo9ocSMH4wGhHnqjTFYEbNpCysvQrzaREDMDIwtkz62iMdbDlFNYXLfXnwRgQXN9XPoWryIyJC1SDF9fjcg95J1Sz+j/fh7F82i3E6N25OCiK1dIhE7qECgYEAz4pO7Wwy6tD0QjJwlDfDHsPQY7XcF0RRpZbbRGRqEsv00IL9B8Hn26uusW4nGza8QXgOjwosZMasisCF2Lg4OyGohBCLlkEWOj2/PvDLIroIP7rC+0S7azQvn9zxC/UcDFiFGBk0jt/y8tUNF4iMHBr6WS1G4whL5g4bzJdUQg8CgYEAzQY8FSSqien8Xg9CaK5z40zLPeWep/epGlP8WpzY3qiE8Ik2OLHlp17qLc3WrRMyBKnGyV91S7E45CC7yQKt4A1X83BTpbCCZdV/9kwdZrHVWL6Qa76xvdWKTCImwXHRDzuDsEmnjFNbyxdLi+75k1sVa2C7HfRy4VkpNkn66jkCgYB7u1mS8w7oL+twC+JSe2w4y0VSLPoqZPDIaEgRXkxfKHmsVmvEVDaHILPl1GY8M0XJQmprnQUaj9gOYPlrW2kq18Y/9h1CV0uJLYb3X1e8PGzukcntQ+z43QQHqxGKr3cpZRz0YRKUm6+cVqiXfzEJEIxw3i2E7U1SutaYAyCYwQKBgFqOnW0tU9I0so6NKOT54SANpFvDl09TebKyU+1mB/hY8NcZlAR4txo1NzRiDadGqjobDz2U10dGkP1aY/dGIqyq2CUjgR7XFtGJ+so8FmRsufJHwZyFjxZtQnecQggBkLisrd7ouYOmsg3DTVASjtQCUDSsdhmmBjP44NYk2RopAoGAM3bfSeUalF8Cg7BjCJJKYHio8YxNMD4NXFkMwcTsrcmGA/MMmiJzmkLdEZ9ZLRrnbwfgN/neZhVOAMRJi4jWXXsvnmJ9OSRpon10F3xLjG9PfYOFnytcv9SjZIuWQNgVvtNdRPSFYgrYi9GZwKbR4WfA3IOamScAs1ZNQc+qF28=
feb48413-f9cf-4315-bdac-8c37a12bf838	96330562-e1e0-409e-ad42-dfe6f93ae1b2	priority	100
1dac1319-15a4-4b1b-ba52-a843621aaaab	96330562-e1e0-409e-ad42-dfe6f93ae1b2	keyUse	ENC
5c68ca4c-65fc-4a7d-b483-4e7dfdd9e51d	96330562-e1e0-409e-ad42-dfe6f93ae1b2	certificate	MIICmzCCAYMCBgGVubPhwzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzIxMTcxMzQ4WhcNMzUwMzIxMTcxNTI4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCmNs8nh8ci0SZNRwKQh27ky2lu9jDMhKt9TEPxFcKxUpK5MZIsVkIKKNwGZaBAwaoUdGcnvNoeSKA5YPZrIOD3cvz9b/tEDGZOKeeueBw6wnYctNYUsmpdTvHR/uPL/SLWgCzc84JFfVpGp3mYW9kx1b2v1/VvYRXN3MsAQjQQ1HozmENCG7P6shPbDSPEZPRSYrxzu/f/dYz/8a9T+hcDTQyJat0azQFQgEhdkZqHpM3J8t3pidCbEqfplz8bowuGDnzZ+MMrRJR7pJVzcMGu3UJyNOatsqjponolz3yXZ7TbQh9Y9XYiaA5Y0WV3F+fza5rpdJjrUCwRWCl/ymtXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJ0W9asCcIPTRSws2fyVmwDEPy3NSpv7Zyb+YZb1mpGqRY1hdJCmxlDcvKv/zD9DKNnbFKRC+OKPdL22+pS/8sB9osnGQJtpv0JHQluoRwwN03dKJBcPdm3QuPYB+BsOlsIwUCkkUHWTo7D+lSqO6cf5y8dVu5Kpzj1Y3zeM3fNHnA5WzCzV6a8JCNKX/Ca5GJr0ACGPjhMiYkVaWXVyH4IyubCsBQQieoTqhW/8DgUBZ/wnpgKpc/Ud/o54ka4w0XVk832IqqidztaOTvh0w12CVsBpQxOsGgX3gRAuZUwToUOmkmCeax1WeIn40zXvTS7jIIvAUlgQR3GyPGsuqnU=
9020764d-afd1-4be1-8655-b06bb2f7c62b	b0c415d0-1c9a-4ca8-bdda-7bdd337ad1f7	keyUse	SIG
676a0374-c0a8-45b7-ae25-b53714ee9ee3	b0c415d0-1c9a-4ca8-bdda-7bdd337ad1f7	priority	100
5c93f35e-5cb3-46a5-a940-ba99ceb18fd5	1523e044-3f0f-4fe6-9d30-81b754f151d0	allow-default-scopes	true
624fc41e-6b4a-4d6c-b257-68f9949cb598	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	saml-user-attribute-mapper
112b73f4-3dbd-4fda-b1b8-ee4ef684d5bc	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
29272c2c-5e12-4864-a3c9-e6df1058b0b4	b0c415d0-1c9a-4ca8-bdda-7bdd337ad1f7	privateKey	MIIEogIBAAKCAQEAsjJGpCubmwY3ypSy6gfC3dtc6ZYzwhT/e+tTJZB6QEWqpOnIuCJdS3Ab9JLh04oqp7FAnv0W16ISR8pzqA+O9QAS7qfrYrPuMnejFxc0D2UMtFXevJ58bucN7WnFGzZXjHrLxGaQstKcdTmlUv8NNg+zaWL3HNEdKfzUq4vUZjLWLLWT6hY0wG4pjZ19CmvOLY15CvCiXR2O3qpE+e8a7i6Kk9CSg/9V9Vj/pNfrRs0sivYY1SiBGTIfCqjcLOfxMUYS/JmzvSsh+p6GsTBqK0WEzQ6NPq4C/qBy/q9rbfbSLF1gZTX8lzF78PGJ9gAzgGkrjhh/0No/ma9jJ28YTQIDAQABAoIBAAkQsbNMXKAoUtJFekyZlHpA3JstfviSpOSi9hnlHbMDWEkHc6SaavCZhXKNvltKnhzl0YnFClJx9kgcroGQOQ+Rr2TgugLNcIK0v2E/VvCpjVnnPGuQDHh/3J+FT/ewbgfBf3hAV4AhYsA77IMqYnurlM75r+SRZtBqAk+vz2Bbg/pI0KufRFHxrQMdQvNgLPAJXvMHNChV5+eHC95PO9P8sghHufeDig0p+5ygUd09BlFecswdAKq6edhUPYbt1z5DPJ001BkT703QxZjEwQxWvGlhFh6urCGSH1rzUNQTxS/1aXYmQsaZztERat54DgyP0PSB5R/GR/olfAeogWkCgYEA18ILyKqgHFF823jpJulfb5FlFgkmHrZS6nYhZ1w5oq59rGqQoXIk3NSmNF1ea9cDvrgregmcWHh1JeGXdWl7MWiRqks4B9aY4Nz8Ln2UelwfyMNKGwwBq8trXZhNnJ7xXHXqoP0e5Zj7o+U7QcUyLtTIqh0ZEQkLGYgDChPkYYsCgYEA026/rlfiNnCh1hUk5dIuSMlv39QEAv7vevz2j3+toIs075fWkv13dFAmEKVPiSU8yynOcl7V9zMAf+60gMfF9a3LEeRoygHndLv1USw1+xbhffzApTNhVhs7J77wpO5NsaAiebhGUW/OiVncXzwZEueu0x2LXNaY9TN/8/Cj+IcCgYBWuNJPt/VfLInJFZJxZ4BKseA1uTuvQI2XXCAVEYbBEu3ErZiwq9aRRJABoD3hjq0crZ4cEVzcWp6LuV9NfDZeJ6/VCSLeU61jRK/AaA2UGQ9VfNl+gZbyXHMtTZh0iZZuGZ9TUipnEtSijfMBfqerFzAI4GVA6aeifX7rQA+d/QKBgEMRjYJLZHmqbtvPJz4z1vTF2VQiGAevQN49oiTQ9o3HusoJ20oTVzIxPnHnTnyNsGQt5cwH402gAxeR6/Yx6MzPDWymjMsPoZE5Ek9me9UjY/IoHCALVWQQDUrFWeanpUOkLWt5Fe09T0HonGwlTzrc/WsAozWW6TxW0s7Z1dm/AoGAXHXgaM9KVR8cvn9GXrn1I802ZHoChPagUV1iP3LJVeBwNSvynkXRPZGi8+DYXKbnQyQL3DCt3jQRCtgdQ1yXVLlXmCltKflFvWt7h+Z85VIh9KoEVJkf+UDex0M5QfPqnObyWEXr91RGCLatqqMB8wwqLY9pUw8sXC7WosFqZo4=
83825cab-1d15-4f64-803b-539b9fcb0f54	b0c415d0-1c9a-4ca8-bdda-7bdd337ad1f7	certificate	MIICmzCCAYMCBgGVubPhHTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzIxMTcxMzQ4WhcNMzUwMzIxMTcxNTI4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCyMkakK5ubBjfKlLLqB8Ld21zpljPCFP9761MlkHpARaqk6ci4Il1LcBv0kuHTiiqnsUCe/RbXohJHynOoD471ABLup+tis+4yd6MXFzQPZQy0Vd68nnxu5w3tacUbNleMesvEZpCy0px1OaVS/w02D7NpYvcc0R0p/NSri9RmMtYstZPqFjTAbimNnX0Ka84tjXkK8KJdHY7eqkT57xruLoqT0JKD/1X1WP+k1+tGzSyK9hjVKIEZMh8KqNws5/ExRhL8mbO9KyH6noaxMGorRYTNDo0+rgL+oHL+r2tt9tIsXWBlNfyXMXvw8Yn2ADOAaSuOGH/Q2j+Zr2MnbxhNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGKAnQUktc9Xde/8zsR50mrAx5Ox5ucsqXFUC4BcNzxgU0kspaxQMzQez5Mc5mhIbti+EMzudBrEVguirjIo24qHa4Qc43LiTscD5WHPZiCjrfndPgFkKZtl3tU7EsqKiJMIF1R8lS9sJ4INA2TDZQuVuCVskuKmIcQSAo6QGEBu2iy6OJxwth6nyYGEMCmUemhFgus3laom70SWvzpI56kA5aXBpKtz0xDlO2O5ferNWgquEmFj3YBAMy4z4ypRuDOUcP1YJWuqW1ao261KoqeUQNhydpIzvk6tUqRTkKdLNyQ0rlN10O2PfUijF6ixp7jm8weuLDFIsPORIMh7ccI=
786267e7-8f7b-4291-bdbe-58b2e8589285	890974e5-5448-4c86-96cc-52a677ad89b9	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
4c4336e6-632e-4043-a1a5-312a64ed9f78	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6fc3f333-4a10-470e-8d3d-33a5b3d30522	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	saml-role-list-mapper
0951c48c-6ebb-46ed-ad2a-08f51cdbf592	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	oidc-full-name-mapper
a9cb1689-9bb3-4e2c-b0cd-bfec317d399f	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	oidc-address-mapper
dcf4082f-b2c4-4796-9619-d4718ab11abe	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
04d7290e-8fe3-4041-b1f5-1fe2277066d5	db7ce95b-21eb-44fb-b533-aa8a3ad1e2f6	allowed-protocol-mapper-types	saml-user-property-mapper
0133e9b3-a0ad-49d7-899b-fea177df77a5	3dabe2a2-261c-4f64-9fe6-a78c6e53f35a	allow-default-scopes	true
c0666201-02fd-4b1b-aa43-065094306f9b	db2abdfe-3238-4e99-b675-626db5bead4e	secret	DXrXa-JbLhWoqp1v9uagcA
5f741bf4-337f-421f-a25c-25d569b1ab06	db2abdfe-3238-4e99-b675-626db5bead4e	priority	100
95aa9bd2-6d14-4120-b59e-b3c7f97441c6	db2abdfe-3238-4e99-b675-626db5bead4e	kid	431b98c2-8cb6-4363-9c16-9b81dc562e9a
0bb8f9c8-2146-4eb5-8921-5552b3b130f4	c07a4b5a-6505-4da5-aba8-b912beea9ec8	algorithm	HS512
b6006ac4-7e2b-469a-8bde-eb8682458f2d	c07a4b5a-6505-4da5-aba8-b912beea9ec8	secret	Hnipx3pYAnZUXPKjvIxgppJdIZHHIbheGW5fKo4yICMGzcnhkR3UcNqL31USgn1XsAQWqi4XO0zezbFOs7Cdzt_PAiDjyQYvuaIEdl_WyJ-vZr-y6sltWketBnhJw_G5dPEGpXy3hi6NMlUifM5ScnmUDuzzNpKPcH0FIiu01-s
5ba47a93-9925-4917-9588-70716c5d0566	c07a4b5a-6505-4da5-aba8-b912beea9ec8	priority	100
b93225a3-3367-419e-bf08-8fa9c6e9b753	c07a4b5a-6505-4da5-aba8-b912beea9ec8	kid	b80bb02d-0190-4d4c-8aad-558598aaf7d5
35fde6b3-e21b-486d-b30d-0d5a7f362a74	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	saml-user-attribute-mapper
1288127e-b589-4016-991f-aec8a48b9a88	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d166280a-bf38-4dd1-a373-8c9802a0170a	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	saml-user-property-mapper
03387e5c-c4ef-407d-8f19-6c25affaf0de	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	oidc-address-mapper
b49f496d-6ace-445a-84a9-8ae6cc01d017	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
302935b5-fd01-4580-856b-07890f3c178f	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
01da7302-46a2-4ccd-abfe-a02a1da8c03d	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	saml-role-list-mapper
0e2ba988-c060-4d2e-9977-8275289bc5bf	affeafb8-0b50-4c0e-b0f3-db6feda8f9ce	allowed-protocol-mapper-types	oidc-full-name-mapper
51afb747-9e74-4577-b186-4b45b1b8d095	3dd19d14-b90e-42f1-97cc-ec1190f5aeb6	max-clients	200
64a7c6bd-9f85-44ab-b157-196e8ae43dd8	2e142c4f-430a-468d-96d7-59f10d4a4614	host-sending-registration-request-must-match	true
37ff2ffb-6b8f-4bc8-b9dd-85836ca7850d	2e142c4f-430a-468d-96d7-59f10d4a4614	client-uris-must-match	true
b948cc46-f0a0-47fa-a419-ae5782d06d29	3ec0bc93-fdcd-4b65-89a8-9d863c57bd07	priority	100
7a64efc2-57ee-41aa-9a84-34efa12c1d71	3ec0bc93-fdcd-4b65-89a8-9d863c57bd07	privateKey	MIIEowIBAAKCAQEAw9Fq0uSiHF/D2/9CnvUHvhHCqZ4dLXpVjSgdF5nhMGaNXwydNKq/7T8Kc5oxMJa5sl3N9uIkfledzgybZuqr1UQskHvLYJe3t9Zf10LBRvN1yO7ykvq9/1mz7BdROuQGviabEoiB55fGbAf/a+eYEH5Yf7WR6C0Qk7jd+X6WTr2G3MBOTsczlTTmXmiHRwO79ngjfYRWn9fEb4VxqkjI4mnUVWoOX/Uy1DzKKXFjCd/XgkVqyHxxiAJd0VEK1CToaNg59rdJFsLxDIj+RWQ4zhq507iL1fN7PdQPOaEeSMnswxJBpsAIjqVW9pFBUM517cw6IJdfvR8++zs6xG49kwIDAQABAoIBAATttOwY8BGZwXK8kn8wuKCqjsU5Iw/dd+DFJTJOX7IZqq49QYmtUIZWo1s0gs9vw72/CauQlo2Ng/3HKHQnLOsBu8NpMj28o9WfMitXVUkFYK4NgZJ8eCLArbwf/B3o1lib3SRSxj4/fjGC5AVhv1yO6YhRWBpJZBTrvr6EVqElrbzDxlSIRYZGwe4j14UqwgqG9Mc/21qhSS5KDuhAXIOspCHdhP2BtfKCHb+7HH9bUsqVfpmByMk3k+e6nZhJqstAm0FQcRmV1eJ+1LdlXjwOahc8Vp3GmQFGcIDRCyjtmmuPMHUUnUeYJe1ed4VQJ27MH6SL1QhRtzx0M1IHzBECgYEA8gMwAbPtqWuT+pooYeyPlWrSR9EVoM16L20BqhDEkVRz+zAKrC2vUi8DWnIC0qQU/5Tw2ncpabrIGVefluA/MFyAsoqRohenyv56a1W669KmL6SwGALH3fyIZi91r2K0yFbag1h/U3z8TReyJaJV9Chn0jmdYHMu+LGhvZVwH4MCgYEAzyK853IESb9t1B1esfY62ZmxmxQ9Q3FEZEQMjoQijk4Sb0yxHjchabq1ogZLYEqBVX9ADI3KzFxDo1Toa6ojKjWQBSVEtJJ6IoL3Lwfb8+j2pqOs/GHDvi1IlzrRMFuuqD0ZFs34VDFU/sVvdbsXn/b4Kgd+midKb7L9PTS3fLECgYEAi3jMzN5t5AqMgIshJLYZVYn3X84egcqJVRWkNOdu8TZTlPpt3CaD+IABlblI6S4Ir/adC7pK0pUDRp+Z6HCZ2fwlaz+yiFDLsZAQ6xTAIbIHdkOZ/Gx11Pf5f7JwR0BCYYa0baet0WahXKiAUXIJySkUFDKCARjAhDCSvtiFgpMCgYAxhSiMXKHRz8Y+E9dzzF49b5UacjhDS20CW5J07/oi819M5JTjmGKQmGacGc0jdCx/eDCjz7JQMS6qeb4nH0HQ8YVA9av7T5mLbqwRvltDcMqnBDJzFBxr9v+HyDQCz6ht6E17OjrIRhL/5cvD5bq8L5sc0TXfPM167tvEKjpDwQKBgC3EbdUhlNXeuNotznc3aogaTWncsVxD6v3rYx74etW0gK1Cfa3h/ilLta1yagcT8cD/vc7GwLEuHHOQTxv5QkkSgCaBmV3GJt0yfz+no34HJiM62jv8PvgBCKQS033iFPOauq8kQsAtS4gdpSFQ0YQv1D+tl/cqN05+7H0+afqn
0d51648d-a218-4a92-a32f-3dd95fd55280	3ec0bc93-fdcd-4b65-89a8-9d863c57bd07	certificate	MIICnzCCAYcCBgGVv9500TANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhSSC1SZWFsbTAeFw0yNTAzMjIyMTU4MDJaFw0zNTAzMjIyMTU5NDJaMBMxETAPBgNVBAMMCFJILVJlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw9Fq0uSiHF/D2/9CnvUHvhHCqZ4dLXpVjSgdF5nhMGaNXwydNKq/7T8Kc5oxMJa5sl3N9uIkfledzgybZuqr1UQskHvLYJe3t9Zf10LBRvN1yO7ykvq9/1mz7BdROuQGviabEoiB55fGbAf/a+eYEH5Yf7WR6C0Qk7jd+X6WTr2G3MBOTsczlTTmXmiHRwO79ngjfYRWn9fEb4VxqkjI4mnUVWoOX/Uy1DzKKXFjCd/XgkVqyHxxiAJd0VEK1CToaNg59rdJFsLxDIj+RWQ4zhq507iL1fN7PdQPOaEeSMnswxJBpsAIjqVW9pFBUM517cw6IJdfvR8++zs6xG49kwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBCk6nMDNiyAy9Y6bibbCoDxepXOKjVvZbcTBJ0nAtfIKWAYcsT5qpDWDmKbZbT3xfktoUEMCmkGyAhOY60Cbj9kagevWaBWC8c2JCwJjUiyM2ggRJl7QrfMMFt6IiMrIwKXLZ+iU7kwV0uSEsUGy3gpGsSn8Hn/CPGVfABOYtkMLPSvnMGjVgq85Ri3eYrSKvii13c7imMOE3PzY5+wcX2X3dfLLavop+Kq3JhPlV5M13JU3v3i65+AqmtKLFDl3u3ARy3oGQQ/F9i1DEJzSNZ08YrXH9bSxFgNVOJpKdxgc6pSAt0Bn4cmT13+jVWdPtkYT5/I4O9F8T1gV5y7gtt
929dde95-0365-44c7-98ca-5bb6b28594e7	3ec0bc93-fdcd-4b65-89a8-9d863c57bd07	keyUse	SIG
9e3c3c26-3c85-4780-b30b-9f4a884c5303	f87d7840-58ad-4713-bbaf-325b6c18b002	priority	100
46ad7e29-c7e8-4d12-9a11-6f94232a9ec7	f87d7840-58ad-4713-bbaf-325b6c18b002	privateKey	MIIEowIBAAKCAQEAu6rt1VL1y2l8BYiyEKLqKroqwNQ4I5wAPn+4ki8xOCp5w79ISM2w30Pa9zqYLN3O85kngOztZ8fDvkKoE7EpX/deGgKiZPHhAMiM4Bs8PhOa+3GxN+uBkGNGULmEkKdglT9QB0JhNZkBNKTZdk3rIZ0/zBHZZJ/URNbkMxfYqrcyB30VmS+hDPOdfildpGu7ebDuodtV0o/NPcEqFJABteVnOOwdz0IGPB2VX2GE5uTC/Imc3KNMBOCXgggFpw/6nOYlQg5FGU2bBt3IEyHs9cVLXGpD4boMT4o7+q/ZYK4HYkVM2UorEoFck9W1eZoBs5yAjRKH3WO3xtJlBQopHQIDAQABAoIBAA+o9Ac20MFsWDfLABbgzVsK5WnpW5TnHeMZO9DhBMGr07TYp6LBnUaILkOunUezK6OKrm/09VuRYR1liQp5oFr8dJsFiMEVKQIsegryYtzIPIjKZDAnJAzlJ9cxH+WFPgs+OQKeEKgNEDtxHR9g4aPQsCPqgmJB7w/egbTcwsz97zNQNBbv7red2EPIZuVzxbHLslEPDdUNkhzUoyjZoUddoUoAcAOQd/jg5UE4NFrZTRibV0aee7AiF75SeagiioihCDiNcd8WWaffdIelG+2gwBg/7O2lDWk3VFG5a7jn7ZR3RlenfxBxGJAp8+qX9E1OgnJDTpXAP71EWfTUn7ECgYEA84z0vXCUo4us4WjFRSPXXpzJnd0huhKirD4aAJDwIgl8al8P2Pt3FHNelqoBowtYfE8FMjdZ7o1FJKog+9QSDD+Wj2ii0Up18s/8fXsHePDIYHQEy5hg/mOrzgcVw233C+B0hrCPCVl/Cr8NR5YEODIITuYgEjN9zfbm6Gtb6C0CgYEAxUKz6C3Y5yB3pYC1yPP8N/7nzUBiK3Suc80MwVAAWJZsubGgiWftp0d7hZEb+pJQ3P5dELwGWhRjkr/UyGxoOGOIodE+Tmp05aHZxWA3NyRO4r08O3ykdAolBPxzISHnxbbKGceC3alp0cot7KP2dSbGBkrAeN4WwvI9d2tMarECgYBzzxPVPMJBHjqfmI0tOkS/xXgNa8gMza2yj3kXydOVq8MQZZGIkNJn1BAnPkG3AL8bpQuIfE90IpK9Q3SZqpbGYjo6iPva3zhEtGeQVz8PYBc33hMlqJh+fnCEcFQF8LUnXZyrKytou7iwKHatEoWBHzFaKw0W+osYtA3KeLpkJQKBgQCkjtCmkBiyN1OYrZb43RE7ZVrazysWNXCTCivp2GNxg4uQHa5e8mQ/eFKDSlqc3hK3STs6CqEB5KBse7t2t3j6EY6Z74SaxhRevHZ/QZTOW2uzm0n0Fjba1turHS6uJSrEtYhDmTyCziGI8bD+CIpBkOcBuLp4Gk3Cs3KzfL9zAQKBgDr5xoLVmD/RKA6U4yCSZBOUkPkoovpEgTm5LwqfmwVfeSfgsq9IhTs9Su+nvRdjC9uKIaM9wnKyD/4qO45wy47LapVu60qSUnjtGrJx9xJhptF1y6SQPG1gKhdrvMkWa/cF3YYSuKkHGUWAljVOjMmvefm+h6Y71eN97PTdPdp5
3a53e43f-b45e-4b4a-bba3-936d55db14aa	f87d7840-58ad-4713-bbaf-325b6c18b002	certificate	MIICnzCCAYcCBgGVv951PDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhSSC1SZWFsbTAeFw0yNTAzMjIyMTU4MDJaFw0zNTAzMjIyMTU5NDJaMBMxETAPBgNVBAMMCFJILVJlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu6rt1VL1y2l8BYiyEKLqKroqwNQ4I5wAPn+4ki8xOCp5w79ISM2w30Pa9zqYLN3O85kngOztZ8fDvkKoE7EpX/deGgKiZPHhAMiM4Bs8PhOa+3GxN+uBkGNGULmEkKdglT9QB0JhNZkBNKTZdk3rIZ0/zBHZZJ/URNbkMxfYqrcyB30VmS+hDPOdfildpGu7ebDuodtV0o/NPcEqFJABteVnOOwdz0IGPB2VX2GE5uTC/Imc3KNMBOCXgggFpw/6nOYlQg5FGU2bBt3IEyHs9cVLXGpD4boMT4o7+q/ZYK4HYkVM2UorEoFck9W1eZoBs5yAjRKH3WO3xtJlBQopHQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBomWgi5d0Eg8fucWCvz6fm230oh4f8RdDq2hrBap1y96qRVpFALSEx9kVjsuax2qikh9ZEhuZ6Fa2CfrAfGAAKrR4yXwoOlNEOYUEURjm2f0h2dR+FRdiBzr6XnI0Dc+C8cyDfQjWY+72QilR/aJn28hpJSAutAK7FU8e6ecX6/rQxUdLPKa5HL00IUX+QiiRRPRSeH8jQ7DQLmiCi+vKI8BJ6A1VpFdfxURwXiMANmm/CswPJ3koo1sYrTsM1bynvDz3lE4egODYIsVGQ2nKn5pIWJoGbQJ6J1SVVHLpIoVt5rwrdRRThGgq9jmSM4gQdp6bEgiasAs+G9AnsMU5E
4843e72f-0c30-402d-96bc-b8fde7763c6b	f87d7840-58ad-4713-bbaf-325b6c18b002	algorithm	RSA-OAEP
10a2228a-af33-433f-9aee-10e990a82f00	f87d7840-58ad-4713-bbaf-325b6c18b002	keyUse	ENC
06cdab17-ff8c-41eb-98fa-082282ba9297	f0619eed-0ff7-4f80-bac6-379cc1b13e14	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{},"annotations":{},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{},"annotations":{},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{},"annotations":{},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"cin","displayName":"cin","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"telephone","displayName":"telephone","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"photoUrl","displayName":"photoUrl","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"departmentId","displayName":"departmentId","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"salary","displayName":"salary","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Gender","displayName":"Gender","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Street","displayName":"Street","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"City","displayName":"City","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"ZIP","displayName":"ZIP","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Country","displayName":"Country","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Birth_Date","displayName":"Birth_Date","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"Pay_Schedule","displayName":"Pay_Schedule","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Hire_Date","displayName":"Hire_Date","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Pay_Type","displayName":"Pay_Type","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Ethnicity","displayName":"Ethnicity","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Work_Phone","displayName":"Work_Phone","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Work_Email","displayName":"Work_Email","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Job_Title","displayName":"Job_Title","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Material_Status","displayName":"Material_Status","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Mobile_Phone","displayName":"Mobile_Phone","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"Location","displayName":"Location","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"contract","displayName":"contract","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false},{"name":"isArchived","displayName":"isArchived","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
99ca1fb6-a6fb-434f-92b2-7432de3fca99	420e0813-5169-4e75-bb9a-10c918d17d5c
99ca1fb6-a6fb-434f-92b2-7432de3fca99	f068de93-1ae9-4fea-8a38-488ef1b5475d
99ca1fb6-a6fb-434f-92b2-7432de3fca99	00c9ac92-3b99-443a-a9a4-b6ca4c5a40f5
99ca1fb6-a6fb-434f-92b2-7432de3fca99	50d641c8-6e90-4b6d-bdb9-e8ad926ba68b
99ca1fb6-a6fb-434f-92b2-7432de3fca99	64b992c7-455a-4353-b321-e8ac9b359974
99ca1fb6-a6fb-434f-92b2-7432de3fca99	03d8ba99-3006-4013-87d4-7dd7b23faa3b
99ca1fb6-a6fb-434f-92b2-7432de3fca99	51573a58-edae-48cc-8902-6afc9b02894d
99ca1fb6-a6fb-434f-92b2-7432de3fca99	b46ec6f0-756a-446d-ab54-3aa016541e36
99ca1fb6-a6fb-434f-92b2-7432de3fca99	fa2b5177-9a38-4070-8ca8-d42b5a085c12
99ca1fb6-a6fb-434f-92b2-7432de3fca99	ee5c6ae9-ee24-414f-aefc-47e7bb252134
99ca1fb6-a6fb-434f-92b2-7432de3fca99	f648e172-4c79-4348-a538-2fae592a8594
99ca1fb6-a6fb-434f-92b2-7432de3fca99	f835ca1e-6be6-4bc3-9369-35ed3a33b33c
99ca1fb6-a6fb-434f-92b2-7432de3fca99	f66293c8-ddc7-451a-b8f4-1f226deec7f5
99ca1fb6-a6fb-434f-92b2-7432de3fca99	a457744e-52e2-4657-8256-d91dcdccb1a6
99ca1fb6-a6fb-434f-92b2-7432de3fca99	e403d39d-0da6-4266-8f24-511c243f6322
99ca1fb6-a6fb-434f-92b2-7432de3fca99	75acb14b-45cc-4d7d-aff6-9618ceaff228
99ca1fb6-a6fb-434f-92b2-7432de3fca99	b966c9ac-6dea-4b07-a973-2b9270430edd
99ca1fb6-a6fb-434f-92b2-7432de3fca99	985c9cb1-a564-4685-8732-38ff5d0aaba9
50d641c8-6e90-4b6d-bdb9-e8ad926ba68b	985c9cb1-a564-4685-8732-38ff5d0aaba9
50d641c8-6e90-4b6d-bdb9-e8ad926ba68b	e403d39d-0da6-4266-8f24-511c243f6322
64b992c7-455a-4353-b321-e8ac9b359974	75acb14b-45cc-4d7d-aff6-9618ceaff228
fecc98c6-6655-4281-bdde-06e6fead3a63	bab2eceb-bf44-4822-82e2-9000005929ff
fecc98c6-6655-4281-bdde-06e6fead3a63	4a7b202d-9b01-4f71-b751-4feea19213ad
4a7b202d-9b01-4f71-b751-4feea19213ad	970b8218-e6e4-48d0-9f5c-a53c797ca7e9
4d67b065-ac4a-4abc-a031-80e6b9938f9d	ec5e15da-2ad9-4f27-91d9-9e8a01c53484
99ca1fb6-a6fb-434f-92b2-7432de3fca99	bff4f928-de66-49a9-a19f-db80eaedc6db
fecc98c6-6655-4281-bdde-06e6fead3a63	e3c526f4-1b7c-43a0-a3e6-4b27325fc16f
fecc98c6-6655-4281-bdde-06e6fead3a63	1125526e-1dc4-4249-982e-fd555186d22c
99ca1fb6-a6fb-434f-92b2-7432de3fca99	bc1f2c60-adf5-417a-a9f4-81b2fb364f78
99ca1fb6-a6fb-434f-92b2-7432de3fca99	8ed72cd1-8049-4560-95d6-1d057e607822
99ca1fb6-a6fb-434f-92b2-7432de3fca99	773f26ff-b20e-4c81-b072-0247282311aa
99ca1fb6-a6fb-434f-92b2-7432de3fca99	c2f1026e-70ac-4a69-a97e-20f18065d199
99ca1fb6-a6fb-434f-92b2-7432de3fca99	d32747e4-5764-48c0-9526-203530253b5b
99ca1fb6-a6fb-434f-92b2-7432de3fca99	be3ce40c-1665-46f6-b99f-cbd06d41932c
99ca1fb6-a6fb-434f-92b2-7432de3fca99	cc7b9c01-2bb3-419b-8856-a9fb217d6d54
99ca1fb6-a6fb-434f-92b2-7432de3fca99	27bc7f62-0ebd-4094-983a-d936132b7018
99ca1fb6-a6fb-434f-92b2-7432de3fca99	a1f7872e-cf74-463b-b06f-22f7fd47c954
99ca1fb6-a6fb-434f-92b2-7432de3fca99	790f4901-7d58-4a1f-a71a-d689dd83bb94
99ca1fb6-a6fb-434f-92b2-7432de3fca99	2cbfa34c-c32a-4704-89e6-013b87525351
99ca1fb6-a6fb-434f-92b2-7432de3fca99	1e933c46-943a-4188-87c2-35a38f53be22
99ca1fb6-a6fb-434f-92b2-7432de3fca99	1fe80e3f-bfd8-41ac-a221-8acf32fcff09
99ca1fb6-a6fb-434f-92b2-7432de3fca99	f5130286-3c59-47e9-b17c-2085cb16302a
99ca1fb6-a6fb-434f-92b2-7432de3fca99	89ebbb9d-81c6-48c1-aa1f-46a116b5029a
99ca1fb6-a6fb-434f-92b2-7432de3fca99	c1c0546b-e8d5-4174-ba8e-04cb1d37cd1f
99ca1fb6-a6fb-434f-92b2-7432de3fca99	ddeca923-8e80-4b44-872b-406a429176d7
773f26ff-b20e-4c81-b072-0247282311aa	ddeca923-8e80-4b44-872b-406a429176d7
773f26ff-b20e-4c81-b072-0247282311aa	f5130286-3c59-47e9-b17c-2085cb16302a
c2f1026e-70ac-4a69-a97e-20f18065d199	89ebbb9d-81c6-48c1-aa1f-46a116b5029a
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	9bc4ea09-73bf-4067-acbc-0f9736e15e5b
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	a4913c90-2930-410b-9284-77f1a6a07176
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	1bfcb7a9-9618-4f8f-b639-16133e3491db
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	b42fe5b5-3cd1-4545-a28c-bb2e21179896
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	5a7dfb38-2afb-4b45-a016-50c0ec190ffc
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	38fa1489-26fd-43a2-819e-898e2dae75fa
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	3851e009-525f-40ca-9d03-58130c900193
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	4d10a48a-fdaa-4056-bee6-b8d11f515ab5
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	ec180aae-504e-43a6-abb0-33795dcb2c8f
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	614a6674-1104-40a4-b2fd-4fdc90473dd2
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	c9944b1b-bb51-45d8-905e-52346871b8f2
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	31981ce3-da19-4fe2-81b2-e66e6318dde8
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	ae3bf6d7-1d00-42fb-b6ed-90b25b2aacee
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	96b45e07-8c72-441c-be73-dc193b2303bd
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	1f3ffe01-1a9e-430c-9990-8441c87bc522
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	7c57ff83-ab57-4875-a750-ce52f5ee1d66
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	c40188ce-8726-4b5e-a191-74dabeb112ae
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	7e1330c4-eccc-45d3-8325-648991e598cf
1b268c0e-9168-483e-b654-942ba25cb253	001e2cd6-f8e8-4eb4-8e2f-6f4376120db7
1b268c0e-9168-483e-b654-942ba25cb253	d429ef84-ebb7-4f45-8e0c-dbc874ebe53d
1b268c0e-9168-483e-b654-942ba25cb253	2ec5cdf9-03ce-44e4-a1f1-452c97ae3e38
1b268c0e-9168-483e-b654-942ba25cb253	5e20a0bb-bf53-4bd3-a1fc-d9f88807082d
301f6caa-e28d-422d-9e5e-488e895826ce	748a684a-7421-4d72-a435-0ff6ea824189
3851e009-525f-40ca-9d03-58130c900193	a4913c90-2930-410b-9284-77f1a6a07176
3851e009-525f-40ca-9d03-58130c900193	1bfcb7a9-9618-4f8f-b639-16133e3491db
626b1100-62ff-40ca-a8b5-1de304572b3d	c4a21585-4646-401d-962d-4be453a1640f
626b1100-62ff-40ca-a8b5-1de304572b3d	9bc4ea09-73bf-4067-acbc-0f9736e15e5b
626b1100-62ff-40ca-a8b5-1de304572b3d	a4913c90-2930-410b-9284-77f1a6a07176
626b1100-62ff-40ca-a8b5-1de304572b3d	0f19e620-3caf-4a3b-9d66-8f9a0373f30d
626b1100-62ff-40ca-a8b5-1de304572b3d	b42fe5b5-3cd1-4545-a28c-bb2e21179896
626b1100-62ff-40ca-a8b5-1de304572b3d	5e20a0bb-bf53-4bd3-a1fc-d9f88807082d
626b1100-62ff-40ca-a8b5-1de304572b3d	4d10a48a-fdaa-4056-bee6-b8d11f515ab5
626b1100-62ff-40ca-a8b5-1de304572b3d	ae3bf6d7-1d00-42fb-b6ed-90b25b2aacee
626b1100-62ff-40ca-a8b5-1de304572b3d	748a684a-7421-4d72-a435-0ff6ea824189
626b1100-62ff-40ca-a8b5-1de304572b3d	96b45e07-8c72-441c-be73-dc193b2303bd
626b1100-62ff-40ca-a8b5-1de304572b3d	7c57ff83-ab57-4875-a750-ce52f5ee1d66
626b1100-62ff-40ca-a8b5-1de304572b3d	89c07c78-a781-4bd3-97c3-95309dde5765
626b1100-62ff-40ca-a8b5-1de304572b3d	07f385e7-3e99-4655-8a00-89031babd21a
626b1100-62ff-40ca-a8b5-1de304572b3d	d429ef84-ebb7-4f45-8e0c-dbc874ebe53d
626b1100-62ff-40ca-a8b5-1de304572b3d	7aee256b-b603-4d1f-a0c4-32043ee4f686
626b1100-62ff-40ca-a8b5-1de304572b3d	1bfcb7a9-9618-4f8f-b639-16133e3491db
626b1100-62ff-40ca-a8b5-1de304572b3d	301f6caa-e28d-422d-9e5e-488e895826ce
626b1100-62ff-40ca-a8b5-1de304572b3d	5a7dfb38-2afb-4b45-a016-50c0ec190ffc
626b1100-62ff-40ca-a8b5-1de304572b3d	38fa1489-26fd-43a2-819e-898e2dae75fa
626b1100-62ff-40ca-a8b5-1de304572b3d	3851e009-525f-40ca-9d03-58130c900193
626b1100-62ff-40ca-a8b5-1de304572b3d	ec180aae-504e-43a6-abb0-33795dcb2c8f
626b1100-62ff-40ca-a8b5-1de304572b3d	614a6674-1104-40a4-b2fd-4fdc90473dd2
626b1100-62ff-40ca-a8b5-1de304572b3d	c9944b1b-bb51-45d8-905e-52346871b8f2
626b1100-62ff-40ca-a8b5-1de304572b3d	6f8f04a0-abdd-413f-a4d4-9cf7ca53ab12
626b1100-62ff-40ca-a8b5-1de304572b3d	31981ce3-da19-4fe2-81b2-e66e6318dde8
626b1100-62ff-40ca-a8b5-1de304572b3d	1f3ffe01-1a9e-430c-9990-8441c87bc522
626b1100-62ff-40ca-a8b5-1de304572b3d	c40188ce-8726-4b5e-a191-74dabeb112ae
626b1100-62ff-40ca-a8b5-1de304572b3d	7e1330c4-eccc-45d3-8325-648991e598cf
626b1100-62ff-40ca-a8b5-1de304572b3d	8cfcbda4-77ad-43c5-81aa-a72eb9ce2015
626b1100-62ff-40ca-a8b5-1de304572b3d	8224e32b-ea3b-4d67-ab99-21aa4e27a85f
7e1330c4-eccc-45d3-8325-648991e598cf	c9944b1b-bb51-45d8-905e-52346871b8f2
d429ef84-ebb7-4f45-8e0c-dbc874ebe53d	89c07c78-a781-4bd3-97c3-95309dde5765
99ca1fb6-a6fb-434f-92b2-7432de3fca99	7be532ca-9b3b-4066-93fa-424bf82f8cd3
\.


--
-- Data for Name: condidat; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.condidat (id_condidat, cv, email, nom, prenom, statut) FROM stdin;
\.


--
-- Data for Name: conge; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.conge (id_conge, date_debut, date_fin, description, statut, type) FROM stdin;
\.


--
-- Data for Name: contrat; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contrat (id_contrat, date_debut, date_fin, contrat_type, salaire) FROM stdin;
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
39474685-242e-466e-93a7-68f3e6a42ec9	\N	password	e4d83a00-a1f3-419f-9a8e-953012942eb4	1742577329703	\N	{"value":"FqS5s7Laf/hiEFDBlNsobdhYvquacobMI/GDJaHk83XLlR6ZjObxQ+HyLCrUL7ZFPAwjeo4jiH/bp+0E/X8aYQ==","salt":"6TDH3tEpTiFsl254H70EGA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
61e0a9e3-277f-4daa-bd7b-112f1638868d	\N	password	d265f826-6244-46aa-ac83-65eaf06edf23	1744497377872	\N	{"value":"7bpMfYgsmUGuR5ycfy1wzd9HLgMpB6YgW9yYOYL/mWTkrgjvOKhRkB3DzgfXQhsYK7IA9tJb4lTGdub5fgjsZg==","salt":"siwDhQTIdjwejGxURO1ggw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
ea8486e0-8890-4139-a865-20eebcf1db2c	\N	password	ec3d7043-bbc7-4801-a2aa-358b63fea108	1743260301219	My password	{"value":"E38z9khzPajV9apD3aMWQnYW/MQsGlyW0e88HUdi9XXHoyBkskgf+RoMAbXXF7JRi9qfLGuQdz0UISZkBGVj+A==","salt":"0VSD10oriMEu0ZXbjGGs3g==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
d797da6a-0660-4ff2-ab5b-48582874a6de	\N	password	5305b46a-f8b0-4575-ad24-f42edd85e298	1743607777516	My password	{"value":"o0Oh0Og6jLIT9BZXdlwCN14xVqjseRnIe6lf3AxbGMSrS1xGWCYUfGiVLSvLDOUp5pnqVwTgHQ1qi7cCotQadg==","salt":"rq4OKB7OARqgTFaA4pLXHg==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
15666100-63f5-4375-af94-764a18d09e26	\N	password	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	1744585361815	\N	{"value":"3f1yRsklVdPBMiHkIgSMauv8riO+Xo4oHiyxEpCtmhyPJn4+Wv9VF+/dteTZFusf+0hPJK6hMFxnpDt3qF0LZw==","salt":"VgIS3iDzMN4m/3Bi8zSNZw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
1a5dfb47-bfee-4bc3-b942-7c1eea94837a	\N	password	8d997418-b42e-44f6-beea-6712a948a535	1744496062526	\N	{"value":"ntCI4s8HEDJbr6OdUl8QLRLFY33fWKlDD9Wewg1uo/BTbgGQAslBgkRHOX17c4SAhTeTs1ECG8tB2is+sMFsvw==","salt":"KWdUWSd3GD+nHcQowCYcPg==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
4d5fb5c9-962c-465c-9af2-6b6a4f649544	\N	password	48e77e81-7a14-431a-af72-7c0c5c40d8f3	1744496948256	\N	{"value":"nPnmcYoFUUcS/DfcYlOoSULghLHzhKg3MCQXlNIeVY6obe3WLCgb783mXOEtAc/g5g2YiAIMgPfT9R8DgrIEXQ==","salt":"MrLFCwMvnIYgx65r3CytuA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
92eb668b-8ea8-4bd3-95ce-c1cb02ad2d33	\N	password	8b78c864-0c62-45ae-826a-79e8c14ae442	1744497157218	\N	{"value":"vFFPrP/Lzt7u1TAOLpA2SijCO/2Q+JU9n9HJBcfeKIFkOg5udH2iKVuMrEpeHNQjN2doJ6lx6Df+zI6hwt/9wg==","salt":"9MyOCJ+1QamqIXzhBPA8Cw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
846f0363-4389-4a09-a879-b75e2e4a117d	\N	password	d5801d06-6dce-4dce-9ff7-d212505caee3	1744632180348	\N	{"value":"nxYfVqxrxyzTWyvWJjX9Q2vwOzc4Ao0egAn6wRVdvJAWC4I1DptifBOGduZkIczPf75rR9EIIKPWjau+XnAlBA==","salt":"ZFPS37Ck5SU64OqkYfxD7A==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
53d00481-0fd8-4165-8f69-e9cc6c3e7b49	\N	password	748218bf-e264-43cf-bfe8-9b36b036e8ff	1744639410721	\N	{"value":"OdURwis5S9TMStwGSO5/XnQznf/+jKrHPwqj6oBFFf/kDynnYRn7qQjZu4y+9p65q8iAV/Fl93pKTgCqPJAttg==","salt":"iAqAmEg1rqKuPFPBjwqKKw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
921189ba-47fd-4b24-9f81-a288c96da0bf	\N	password	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	1744728836337	\N	{"value":"BApcpTVtCwkehFWK2zy4mAcORuG4AYhePEiVWDzPRMmCtnSPalmPSABo9jE1pmWYKbURNPrSE2Xw3al6hYnOOQ==","salt":"aj1tY2Lw/1Axdcy972qvmw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
c35887e6-b2fc-4d91-b80f-586d157fa546	\N	password	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	1744729251817	\N	{"value":"mwYm5bZHkgybsUQwBz8ln8mmidDzlH4853Ke/zo9Dcdp+MzljsIeHHSM87nGdnef8kG6TT33DUTzWUQxsIVWng==","salt":"tweye0a/A9p9Bk3UzqZb5g==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
a9a54c45-52c7-4f6d-b4f9-758054b8575f	\N	password	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	1744802627672	\N	{"value":"o0pruUe3rxju2FdttRna3TxNRrSN4nuORVp3yeTKhxwspRyQp5cEDXbkDGRWq6XRFyyqiUQY4XhJfKTvwdfHxg==","salt":"8Cu897lsRzcstdfFIyBE4A==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
9e106672-dd29-4da9-bf79-de488ce33917	\N	password	36079834-cb68-4a4d-97fa-b1548bee3e9a	1744890460748	\N	{"value":"Yh9rtK5Awjj5OlGX7EI5v4xUhtgy2P17fTs4zbr4zyxPSQvF3Sa+81BsDvqwjz6qwY5sThPGOOs0HDLticawhw==","salt":"ICiy8ceWJ33ApbZdklPXyQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
ce116cfd-256c-4e8b-8429-ba788764924a	\N	otp	38061f5a-68db-4e60-ae9f-681b2ae4c547	1744900673775		{"value":"PbDp5A6kRj26L5lAfOiD"}	{"subType":"totp","digits":6,"counter":0,"period":30,"algorithm":"HmacSHA1"}	20
c6045d2c-8473-429b-bc40-259faeec9b86	\N	password	38061f5a-68db-4e60-ae9f-681b2ae4c547	1744900689157	\N	{"value":"LPHMNaJE7E3HGRgNn9g54rX1qmwYYA0SqugRZiekELp7yjBfA6mJUuzYGD9Rvnx8WIR3842O/7ydms5VKtZ76A==","salt":"VNTy2I+NumRUwdxWYg/I3A==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
81bdbf6c-13b8-49ed-a0c7-99ab831e6e57	\N	password	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	1744983978329	\N	{"value":"7agc/KYOf8R/kQeARGiNycg53VL1TQgn5ZFUWIlMfRzqQIoOiBkkNQyHIH8loGy0qGegA9MjSJz1xKiGW8cbCQ==","salt":"/WnFd9wMT2EWTOWcoOHI7w==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-03-21 17:15:25.608017	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	2577325014
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-03-21 17:15:25.628006	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	2577325014
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-03-21 17:15:25.686072	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	2577325014
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-03-21 17:15:25.690925	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	2577325014
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-03-21 17:15:25.784369	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	2577325014
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-03-21 17:15:25.789169	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	2577325014
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-03-21 17:15:25.880895	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	2577325014
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-03-21 17:15:25.887864	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	2577325014
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-03-21 17:15:25.893704	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	2577325014
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-03-21 17:15:25.982744	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	2577325014
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-03-21 17:15:26.033006	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	2577325014
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-03-21 17:15:26.037278	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	2577325014
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-03-21 17:15:26.057836	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	2577325014
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-21 17:15:26.081428	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	2577325014
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-21 17:15:26.083966	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	2577325014
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-21 17:15:26.087018	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	2577325014
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-21 17:15:26.090524	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	2577325014
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-03-21 17:15:26.133213	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	2577325014
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-03-21 17:15:26.170615	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	2577325014
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-03-21 17:15:26.176021	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	2577325014
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-21 17:15:27.154368	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	2577325014
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-21 17:15:26.178675	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	2577325014
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-21 17:15:26.182065	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	2577325014
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-03-21 17:15:26.204081	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	2577325014
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-03-21 17:15:26.211522	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	2577325014
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-03-21 17:15:26.213421	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	2577325014
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-03-21 17:15:26.24921	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	2577325014
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-03-21 17:15:26.31786	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	2577325014
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-03-21 17:15:26.322793	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	2577325014
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-03-21 17:15:26.386686	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	2577325014
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-03-21 17:15:26.398711	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	2577325014
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-03-21 17:15:26.413815	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	2577325014
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-03-21 17:15:26.419507	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	2577325014
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-21 17:15:26.425595	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	2577325014
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-21 17:15:26.427348	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	2577325014
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-21 17:15:26.448675	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	2577325014
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-03-21 17:15:26.452666	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	2577325014
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-21 17:15:26.458257	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	2577325014
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-03-21 17:15:26.462369	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	2577325014
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-03-21 17:15:26.465882	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	2577325014
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-21 17:15:26.467471	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	2577325014
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-21 17:15:26.469334	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	2577325014
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-03-21 17:15:26.474597	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	2577325014
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-21 17:15:26.583178	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	2577325014
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-03-21 17:15:26.58708	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	2577325014
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-21 17:15:26.591154	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	2577325014
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-21 17:15:26.596398	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	2577325014
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-21 17:15:26.598239	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	2577325014
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-21 17:15:26.626569	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	2577325014
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-21 17:15:26.629964	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	2577325014
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-03-21 17:15:26.665044	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	2577325014
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-03-21 17:15:26.695477	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	2577325014
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-03-21 17:15:26.699181	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-03-21 17:15:26.701693	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	2577325014
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-03-21 17:15:26.704112	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	2577325014
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-21 17:15:26.710263	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	2577325014
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-21 17:15:26.715259	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	2577325014
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-21 17:15:26.737794	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	2577325014
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-21 17:15:26.810571	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	2577325014
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-03-21 17:15:26.831421	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	2577325014
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-03-21 17:15:26.836781	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	2577325014
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-21 17:15:26.844582	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	2577325014
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-21 17:15:26.849568	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	2577325014
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-03-21 17:15:26.85254	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	2577325014
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-03-21 17:15:26.854927	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	2577325014
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-21 17:15:26.857169	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	2577325014
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-03-21 17:15:26.867951	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	2577325014
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-21 17:15:26.873352	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	2577325014
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-03-21 17:15:26.877508	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	2577325014
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-03-21 17:15:26.887082	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	2577325014
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-03-21 17:15:26.891893	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	2577325014
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-03-21 17:15:26.895344	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	2577325014
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-21 17:15:26.900315	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	2577325014
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-21 17:15:26.90528	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	2577325014
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-21 17:15:26.907134	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	2577325014
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-21 17:15:26.918853	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	2577325014
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-21 17:15:26.924788	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	2577325014
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-21 17:15:26.927901	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	2577325014
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-21 17:15:26.929211	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	2577325014
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-21 17:15:26.944811	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	2577325014
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-21 17:15:26.946938	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	2577325014
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-21 17:15:26.954537	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	2577325014
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-21 17:15:26.956472	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	2577325014
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-21 17:15:26.961014	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	2577325014
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-21 17:15:26.962668	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	2577325014
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-21 17:15:26.969781	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	2577325014
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-03-21 17:15:26.974055	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	2577325014
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-21 17:15:26.978953	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	2577325014
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-21 17:15:26.98775	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	2577325014
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:26.993959	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	2577325014
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:26.999135	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	2577325014
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:27.00414	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	2577325014
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:27.009075	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	2577325014
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:27.010474	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	2577325014
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:27.016993	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	2577325014
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:27.018522	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	2577325014
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-21 17:15:27.022854	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	2577325014
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-21 17:15:27.033346	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	2577325014
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-21 17:15:27.035049	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-21 17:15:27.042908	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-21 17:15:27.048954	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-21 17:15:27.050653	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-21 17:15:27.056333	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	2577325014
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-21 17:15:27.061357	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	2577325014
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-03-21 17:15:27.066257	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	2577325014
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-03-21 17:15:27.071491	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	2577325014
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-03-21 17:15:27.076706	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	2577325014
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-03-21 17:15:27.081536	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	2577325014
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-21 17:15:27.087288	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	2577325014
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-21 17:15:27.088779	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	2577325014
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-21 17:15:27.093675	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-03-21 17:15:27.09801	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	2577325014
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-21 17:15:27.120915	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	2577325014
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-21 17:15:27.122802	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	2577325014
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-21 17:15:27.127596	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	2577325014
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-21 17:15:27.129102	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	2577325014
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-21 17:15:27.133642	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	2577325014
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-21 17:15:27.136508	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	2577325014
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-21 17:15:27.149995	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	2577325014
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-21 17:15:27.15847	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-21 17:15:27.163724	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-21 17:15:27.167462	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	2577325014
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-21 17:15:27.168688	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-21 17:15:27.170336	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2577325014
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: date_affectation; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.date_affectation (id_date_affectation, date_debut, date_fin, employee_id, tache_id) FROM stdin;
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	78836fe5-2a85-4dd8-8c52-da0f45ae4619	f
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	a0a3bf93-c4ca-4a00-80f9-6642981d3e74	t
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	811805e9-cdde-4870-89ae-449e5e89484b	t
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	4e11996f-7d98-4b69-8edf-09663ca91a7a	t
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	62995ff6-6461-4085-96b1-99a3c3689979	f
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f8948f94-547a-4ac0-9b28-ce00350f0e13	f
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7	t
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c	t
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	8738ba8a-84fd-428c-839b-b7ee9319fb8c	f
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4	t
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	5c0abf3d-f2cd-4b86-9dfa-8d5c16f29e12	t
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	916fed05-4033-4a33-b05d-4294e47dc5ae	t
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ce2b093b-daf0-4445-8a41-6301b92b85c8	t
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	76eb7e14-0736-46bd-a947-4d357ca06174	t
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0bccc420-0d97-4cd3-875c-585e1ca6cfc3	t
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee	t
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	68b428cd-fe52-43b1-8588-f5bf2a37772b	f
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	3096f6ee-cc4b-4bb4-8330-888c1197403f	f
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	c8cadcf1-3648-4655-b501-b8535c2e43dc	f
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	1f624268-80e0-4624-b8d6-d8621b0356ce	f
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.department (id, description, nom) FROM stdin;
5	Commercialisation et relation client	Sales
6	Innovation et conception de nouveaux produits	Research and Development
7	Fabrication et gestion de la chaîne de production	Production
8	Gestion des stocks et distribution	Logistics
9	Support et service après-vente	Customer Service
10	Affaires légales et conformité	Legal
11	Communication interne et externe	Communication
12	Contrôle qualité et amélioration continue	Quality
1	Gestion du personnel et des relations sociales	HR
2	Gestion financière et comptabilité	Idk
3	Development and maintenance of information systems	Information Technology
13	athis for test	it would be better to delete other department
14	rayen	rayen
4	Stratégie de marque	Marketing
15	ahmed	other department
\.


--
-- Data for Name: document; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.document (id_demande_doc, statut, type_doc) FROM stdin;
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee (id_employee, num_tel, actif, addresse, date_of_birth, email, hire_date, nom, prenom, salary, department_id, role_id) FROM stdin;
\.


--
-- Data for Name: employee_projet_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee_projet_role (id_emp_projet_role, employee_id, projet_id, projet_role_id) FROM stdin;
\.


--
-- Data for Name: employee_reunion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee_reunion (id_emp_reunion, attended, role, employee_id, reunion_id) FROM stdin;
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
fecc98c6-6655-4281-bdde-06e6fead3a63	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f	${role_default-roles}	default-roles-master	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N	\N
420e0813-5169-4e75-bb9a-10c918d17d5c	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f	${role_create-realm}	create-realm	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N	\N
99ca1fb6-a6fb-434f-92b2-7432de3fca99	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f	${role_admin}	admin	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N	\N
f068de93-1ae9-4fea-8a38-488ef1b5475d	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_create-client}	create-client	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
00c9ac92-3b99-443a-a9a4-b6ca4c5a40f5	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_view-realm}	view-realm	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
50d641c8-6e90-4b6d-bdb9-e8ad926ba68b	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_view-users}	view-users	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
64b992c7-455a-4353-b321-e8ac9b359974	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_view-clients}	view-clients	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
03d8ba99-3006-4013-87d4-7dd7b23faa3b	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_view-events}	view-events	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
51573a58-edae-48cc-8902-6afc9b02894d	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_view-identity-providers}	view-identity-providers	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
b46ec6f0-756a-446d-ab54-3aa016541e36	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_view-authorization}	view-authorization	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
fa2b5177-9a38-4070-8ca8-d42b5a085c12	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_manage-realm}	manage-realm	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
ee5c6ae9-ee24-414f-aefc-47e7bb252134	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_manage-users}	manage-users	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
f648e172-4c79-4348-a538-2fae592a8594	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_manage-clients}	manage-clients	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
f835ca1e-6be6-4bc3-9369-35ed3a33b33c	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_manage-events}	manage-events	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
f66293c8-ddc7-451a-b8f4-1f226deec7f5	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_manage-identity-providers}	manage-identity-providers	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
a457744e-52e2-4657-8256-d91dcdccb1a6	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_manage-authorization}	manage-authorization	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
e403d39d-0da6-4266-8f24-511c243f6322	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_query-users}	query-users	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
75acb14b-45cc-4d7d-aff6-9618ceaff228	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_query-clients}	query-clients	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
b966c9ac-6dea-4b07-a973-2b9270430edd	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_query-realms}	query-realms	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
1b268c0e-9168-483e-b654-942ba25cb253	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	${role_default-roles}	default-roles-rh-realm	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N	\N
bc1f2c60-adf5-417a-a9f4-81b2fb364f78	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_create-client}	create-client	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
8ed72cd1-8049-4560-95d6-1d057e607822	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_view-realm}	view-realm	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
773f26ff-b20e-4c81-b072-0247282311aa	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_view-users}	view-users	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
c2f1026e-70ac-4a69-a97e-20f18065d199	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_view-clients}	view-clients	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
d32747e4-5764-48c0-9526-203530253b5b	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_view-events}	view-events	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
be3ce40c-1665-46f6-b99f-cbd06d41932c	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_view-identity-providers}	view-identity-providers	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
cc7b9c01-2bb3-419b-8856-a9fb217d6d54	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_view-authorization}	view-authorization	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
27bc7f62-0ebd-4094-983a-d936132b7018	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_manage-realm}	manage-realm	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
c7a0ea76-222f-4fe7-a405-272f19bca9cf	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	INTERN	INTERN	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N	\N
985c9cb1-a564-4685-8732-38ff5d0aaba9	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_query-groups}	query-groups	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
bab2eceb-bf44-4822-82e2-9000005929ff	c86c3790-9634-4fed-8575-f55be03be359	t	${role_view-profile}	view-profile	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
4a7b202d-9b01-4f71-b751-4feea19213ad	c86c3790-9634-4fed-8575-f55be03be359	t	${role_manage-account}	manage-account	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
970b8218-e6e4-48d0-9f5c-a53c797ca7e9	c86c3790-9634-4fed-8575-f55be03be359	t	${role_manage-account-links}	manage-account-links	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
73f7749a-e299-43f3-946e-0338de356171	c86c3790-9634-4fed-8575-f55be03be359	t	${role_view-applications}	view-applications	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
ec5e15da-2ad9-4f27-91d9-9e8a01c53484	c86c3790-9634-4fed-8575-f55be03be359	t	${role_view-consent}	view-consent	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
4d67b065-ac4a-4abc-a031-80e6b9938f9d	c86c3790-9634-4fed-8575-f55be03be359	t	${role_manage-consent}	manage-consent	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
4bb702cf-a5ec-4698-90af-f00004e60ed2	c86c3790-9634-4fed-8575-f55be03be359	t	${role_view-groups}	view-groups	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
538eb64b-cb85-4ff6-ad6e-cf1ed5dace5e	c86c3790-9634-4fed-8575-f55be03be359	t	${role_delete-account}	delete-account	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	c86c3790-9634-4fed-8575-f55be03be359	\N
49399151-8b8c-430e-bb9e-a136e02baf08	52908a2c-56fc-46ed-a6a0-7043745ff784	t	${role_read-token}	read-token	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	52908a2c-56fc-46ed-a6a0-7043745ff784	\N
bff4f928-de66-49a9-a19f-db80eaedc6db	179a09f5-5f12-4ab7-812a-d47bb60745e4	t	${role_impersonation}	impersonation	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	179a09f5-5f12-4ab7-812a-d47bb60745e4	\N
e3c526f4-1b7c-43a0-a3e6-4b27325fc16f	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f	${role_offline-access}	offline_access	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N	\N
1125526e-1dc4-4249-982e-fd555186d22c	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f	${role_uma_authorization}	uma_authorization	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	\N	\N
a1f7872e-cf74-463b-b06f-22f7fd47c954	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_manage-users}	manage-users	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
790f4901-7d58-4a1f-a71a-d689dd83bb94	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_manage-clients}	manage-clients	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
2cbfa34c-c32a-4704-89e6-013b87525351	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_manage-events}	manage-events	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
1e933c46-943a-4188-87c2-35a38f53be22	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_manage-identity-providers}	manage-identity-providers	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
1fe80e3f-bfd8-41ac-a221-8acf32fcff09	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_manage-authorization}	manage-authorization	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
f5130286-3c59-47e9-b17c-2085cb16302a	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_query-users}	query-users	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
89ebbb9d-81c6-48c1-aa1f-46a116b5029a	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_query-clients}	query-clients	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
c1c0546b-e8d5-4174-ba8e-04cb1d37cd1f	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_query-realms}	query-realms	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
ddeca923-8e80-4b44-872b-406a429176d7	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_query-groups}	query-groups	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
626b1100-62ff-40ca-a8b5-1de304572b3d	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	\N	DRH	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N	\N
001e2cd6-f8e8-4eb4-8e2f-6f4376120db7	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	${role_offline-access}	offline_access	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N	\N
b8e82c4f-e1de-4663-9cb9-b1aca6b4de98	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	Gestion Ressources humaines	GRH	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N	\N
2ec5cdf9-03ce-44e4-a1f1-452c97ae3e38	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	${role_uma_authorization}	uma_authorization	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N	\N
4daf7d76-2af4-4e0d-9c48-bff737ddb87f	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	EMPLOYEE	EMPLOYEE	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	\N	\N
c4a21585-4646-401d-962d-4be453a1640f	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_manage-roles}	manage-roles	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
9bc4ea09-73bf-4067-acbc-0f9736e15e5b	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_manage-identity-providers}	manage-identity-providers	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
1bfcb7a9-9618-4f8f-b639-16133e3491db	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_query-groups}	query-groups	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
a4913c90-2930-410b-9284-77f1a6a07176	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_query-users}	query-users	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_realm-admin}	realm-admin	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
5a7dfb38-2afb-4b45-a016-50c0ec190ffc	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_manage-events}	manage-events	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
b42fe5b5-3cd1-4545-a28c-bb2e21179896	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_view-authorization}	view-authorization	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
38fa1489-26fd-43a2-819e-898e2dae75fa	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_manage-clients}	manage-clients	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
3851e009-525f-40ca-9d03-58130c900193	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_view-users}	view-users	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
4d10a48a-fdaa-4056-bee6-b8d11f515ab5	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_view-events}	view-events	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
ec180aae-504e-43a6-abb0-33795dcb2c8f	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_query-realms}	query-realms	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
614a6674-1104-40a4-b2fd-4fdc90473dd2	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_manage-realm}	manage-realm	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
c9944b1b-bb51-45d8-905e-52346871b8f2	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_query-clients}	query-clients	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
31981ce3-da19-4fe2-81b2-e66e6318dde8	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_manage-authorization}	manage-authorization	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
ae3bf6d7-1d00-42fb-b6ed-90b25b2aacee	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_manage-users}	manage-users	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
96b45e07-8c72-441c-be73-dc193b2303bd	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_create-client}	create-client	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
1f3ffe01-1a9e-430c-9990-8441c87bc522	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_view-realm}	view-realm	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
7c57ff83-ab57-4875-a750-ce52f5ee1d66	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_view-identity-providers}	view-identity-providers	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
748a684a-7421-4d72-a435-0ff6ea824189	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_view-consent}	view-consent	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
c40188ce-8726-4b5e-a191-74dabeb112ae	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_impersonation}	impersonation	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
7e1330c4-eccc-45d3-8325-648991e598cf	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_view-clients}	view-clients	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
8224e32b-ea3b-4d67-ab99-21aa4e27a85f	566f5d77-b470-4cc8-94c9-8e735428c1a3	t	${role_view-roles}	view-roles	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	566f5d77-b470-4cc8-94c9-8e735428c1a3	\N
07f385e7-3e99-4655-8a00-89031babd21a	2c372afa-e895-493e-b75f-55bea5c0c2c9	t	${role_read-token}	read-token	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	2c372afa-e895-493e-b75f-55bea5c0c2c9	\N
89c07c78-a781-4bd3-97c3-95309dde5765	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_manage-account-links}	manage-account-links	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
6f8f04a0-abdd-413f-a4d4-9cf7ca53ab12	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_delete-account}	delete-account	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
7aee256b-b603-4d1f-a0c4-32043ee4f686	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_view-applications}	view-applications	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
d429ef84-ebb7-4f45-8e0c-dbc874ebe53d	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_manage-account}	manage-account	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
301f6caa-e28d-422d-9e5e-488e895826ce	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_manage-consent}	manage-consent	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
8cfcbda4-77ad-43c5-81aa-a72eb9ce2015	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_view-groups}	view-groups	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
5e20a0bb-bf53-4bd3-a1fc-d9f88807082d	29501232-33d4-45e4-b842-cd8ef4557d02	t	${role_view-profile}	view-profile	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	29501232-33d4-45e4-b842-cd8ef4557d02	\N
7be532ca-9b3b-4066-93fa-424bf82f8cd3	6cea6109-8f92-4041-8ccd-42c817d35904	t	${role_impersonation}	impersonation	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	6cea6109-8f92-4041-8ccd-42c817d35904	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ig5eu	24.0.2	1742577327
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.permission (id_permission, name) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: poste; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.poste (id_poste, competences, description, salaire, titre, type_contrat) FROM stdin;
\.


--
-- Data for Name: projet; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.projet (id, description, nom) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
65ccc740-6549-4735-8782-d4953c9a5aa1	audience resolve	openid-connect	oidc-audience-resolve-mapper	b55ec150-c0bd-4171-b469-a65da147094d	\N
a4e39c31-7a60-4e95-920f-978dda764dd0	locale	openid-connect	oidc-usermodel-attribute-mapper	26ee6233-697d-43ff-bac9-31f7d2fce25f	\N
41938e41-b377-4806-908c-4d3839e16640	role list	saml	saml-role-list-mapper	\N	a0a3bf93-c4ca-4a00-80f9-6642981d3e74
146e3cc8-3d91-42a4-bb83-a2eed51bf5a2	full name	openid-connect	oidc-full-name-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
d3be39da-9158-4584-bd65-9cd6d1ccdae1	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
a84867b2-d07a-4b51-adcd-ff201d6382d1	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
814feb33-9207-4c6b-a333-ba30bc6ab784	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	username	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
3c67e9a3-2461-4478-a1a6-f3645cbb3479	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
14b12141-e8bd-4c48-aea3-d2441830d2f9	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
49be65e5-182a-41e3-8969-166417fef029	website	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
94c74d6a-ab8c-47cd-bc24-5368513d1a25	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
8dac19bc-449d-4f03-9503-156e33911885	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
ca2d068c-6905-4c66-9f82-53ebe427a152	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
c71e27a4-7ded-4b71-9315-5f051ecbca8a	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	811805e9-cdde-4870-89ae-449e5e89484b
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	email	openid-connect	oidc-usermodel-attribute-mapper	\N	4e11996f-7d98-4b69-8edf-09663ca91a7a
248cdf33-437d-4eca-890d-9ab2d2a274d2	email verified	openid-connect	oidc-usermodel-property-mapper	\N	4e11996f-7d98-4b69-8edf-09663ca91a7a
a0633876-e43e-4819-b03f-a12520872b63	address	openid-connect	oidc-address-mapper	\N	62995ff6-6461-4085-96b1-99a3c3689979
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f8948f94-547a-4ac0-9b28-ce00350f0e13
cb624e65-8712-4fed-904d-a583bd081883	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f8948f94-547a-4ac0-9b28-ce00350f0e13
01dd080a-201f-40d8-bc15-329d07db9354	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7
bec2383e-3323-41b0-910a-17df493705be	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7
12abdc6e-5ed5-4619-a2a4-af5f11324d35	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	6cc8a25c-dc76-4038-bb2e-c1fe8ef4fdd7
0edcfd3d-5b5f-4cd4-9347-ab9a4dbe8dc6	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5be43283-bb06-4c8b-9eaf-f1e08eaa3b7c
4ca58f5f-858b-4266-b499-2b10cb55c14c	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	8738ba8a-84fd-428c-839b-b7ee9319fb8c
3fa92378-6516-461f-8ae4-81cbb9205f9e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	8738ba8a-84fd-428c-839b-b7ee9319fb8c
c0b170d2-6b47-4328-a3ff-22aaf36471ec	acr loa level	openid-connect	oidc-acr-mapper	\N	1b9b0c99-7ca0-4100-82b1-8eeb41a7f3c4
ea1f449c-e1c7-42b3-80b9-a110d2374800	acr loa level	openid-connect	oidc-acr-mapper	\N	6482a46a-66f0-4dc6-8ed5-f4bf1d6c64ee
de107bc2-78ce-4a9e-905b-b532204a5953	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	0bccc420-0d97-4cd3-875c-585e1ca6cfc3
dbf5d64d-cabb-4003-b02a-985414218672	address	openid-connect	oidc-address-mapper	\N	3096f6ee-cc4b-4bb4-8330-888c1197403f
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	1f624268-80e0-4624-b8d6-d8621b0356ce
70b444c3-b57c-4ce1-a152-d306b0404f07	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	1f624268-80e0-4624-b8d6-d8621b0356ce
77c4580c-6a03-44e8-a26f-685bfc5ecabc	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	76eb7e14-0736-46bd-a947-4d357ca06174
da37de35-ec78-4f9c-9829-5058ed440b15	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	76eb7e14-0736-46bd-a947-4d357ca06174
ef068605-d8db-4eef-8d28-83a1ab095d1b	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	76eb7e14-0736-46bd-a947-4d357ca06174
dfe19673-38de-4cc4-9a47-748e06683022	role list	saml	saml-role-list-mapper	\N	5c0abf3d-f2cd-4b86-9dfa-8d5c16f29e12
10813d4f-38e2-4dd1-b14d-81be46d0db3f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ce2b093b-daf0-4445-8a41-6301b92b85c8
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	email	openid-connect	oidc-usermodel-attribute-mapper	\N	ce2b093b-daf0-4445-8a41-6301b92b85c8
649570ee-1422-499e-a383-52c3e3489918	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
547d7be4-05d5-49ad-a454-bbca71bba6e6	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	website	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
d6ef403a-94e4-4075-9b95-a110648b25df	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
0de6ecac-82ff-44c2-b142-26bc5e103afc	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
fab4a40a-960a-4374-93b1-720fafe8d094	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
ef0b4467-f708-41a1-af98-5820c0e9eb5e	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
4834aa57-44e2-4b65-8418-7339460649fa	username	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
c646f58d-2a9b-41f2-b2b6-3faf39dd5a7c	full name	openid-connect	oidc-full-name-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
4e761775-ad17-406c-994b-e786829142e6	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
c55a0edf-364d-484b-a535-e14149d94f38	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	916fed05-4033-4a33-b05d-4294e47dc5ae
84219968-494f-4907-9b44-5b9a543abbee	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c8cadcf1-3648-4655-b501-b8535c2e43dc
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c8cadcf1-3648-4655-b501-b8535c2e43dc
d70d9a97-65bb-455e-aca5-9c7d277b806d	audience resolve	openid-connect	oidc-audience-resolve-mapper	9728a162-f8c8-4b53-91e2-cddcc88c8fd9	\N
a5b710d1-6b46-4e56-8335-0bfe0882dd75	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	151aede7-bfd9-481c-a55a-63cd79d17dbb	\N
72d733bd-eb8d-4b69-9cae-301072bb6b66	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	151aede7-bfd9-481c-a55a-63cd79d17dbb	\N
814d90ca-04c1-4cee-8bf9-68386c5b3639	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	151aede7-bfd9-481c-a55a-63cd79d17dbb	\N
20448b0d-24e5-46a7-b451-51f4f1a5cafd	locale	openid-connect	oidc-usermodel-attribute-mapper	bf492b87-578b-4fde-b9bf-29832f852159	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
a4e39c31-7a60-4e95-920f-978dda764dd0	true	introspection.token.claim
a4e39c31-7a60-4e95-920f-978dda764dd0	true	userinfo.token.claim
a4e39c31-7a60-4e95-920f-978dda764dd0	locale	user.attribute
a4e39c31-7a60-4e95-920f-978dda764dd0	true	id.token.claim
a4e39c31-7a60-4e95-920f-978dda764dd0	true	access.token.claim
a4e39c31-7a60-4e95-920f-978dda764dd0	locale	claim.name
a4e39c31-7a60-4e95-920f-978dda764dd0	String	jsonType.label
41938e41-b377-4806-908c-4d3839e16640	false	single
41938e41-b377-4806-908c-4d3839e16640	Basic	attribute.nameformat
41938e41-b377-4806-908c-4d3839e16640	Role	attribute.name
146e3cc8-3d91-42a4-bb83-a2eed51bf5a2	true	introspection.token.claim
146e3cc8-3d91-42a4-bb83-a2eed51bf5a2	true	userinfo.token.claim
146e3cc8-3d91-42a4-bb83-a2eed51bf5a2	true	id.token.claim
146e3cc8-3d91-42a4-bb83-a2eed51bf5a2	true	access.token.claim
14b12141-e8bd-4c48-aea3-d2441830d2f9	true	introspection.token.claim
14b12141-e8bd-4c48-aea3-d2441830d2f9	true	userinfo.token.claim
14b12141-e8bd-4c48-aea3-d2441830d2f9	picture	user.attribute
14b12141-e8bd-4c48-aea3-d2441830d2f9	true	id.token.claim
14b12141-e8bd-4c48-aea3-d2441830d2f9	true	access.token.claim
14b12141-e8bd-4c48-aea3-d2441830d2f9	picture	claim.name
14b12141-e8bd-4c48-aea3-d2441830d2f9	String	jsonType.label
3c67e9a3-2461-4478-a1a6-f3645cbb3479	true	introspection.token.claim
3c67e9a3-2461-4478-a1a6-f3645cbb3479	true	userinfo.token.claim
3c67e9a3-2461-4478-a1a6-f3645cbb3479	profile	user.attribute
3c67e9a3-2461-4478-a1a6-f3645cbb3479	true	id.token.claim
3c67e9a3-2461-4478-a1a6-f3645cbb3479	true	access.token.claim
3c67e9a3-2461-4478-a1a6-f3645cbb3479	profile	claim.name
3c67e9a3-2461-4478-a1a6-f3645cbb3479	String	jsonType.label
49be65e5-182a-41e3-8969-166417fef029	true	introspection.token.claim
49be65e5-182a-41e3-8969-166417fef029	true	userinfo.token.claim
49be65e5-182a-41e3-8969-166417fef029	website	user.attribute
49be65e5-182a-41e3-8969-166417fef029	true	id.token.claim
49be65e5-182a-41e3-8969-166417fef029	true	access.token.claim
49be65e5-182a-41e3-8969-166417fef029	website	claim.name
49be65e5-182a-41e3-8969-166417fef029	String	jsonType.label
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	true	introspection.token.claim
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	true	userinfo.token.claim
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	birthdate	user.attribute
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	true	id.token.claim
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	true	access.token.claim
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	birthdate	claim.name
4cfeaec1-65b4-475f-bb83-efd5d989fa7d	String	jsonType.label
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	true	introspection.token.claim
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	true	userinfo.token.claim
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	username	user.attribute
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	true	id.token.claim
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	true	access.token.claim
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	preferred_username	claim.name
7e46c2e5-a7ef-4ed9-9c9e-ff6cf9164369	String	jsonType.label
814feb33-9207-4c6b-a333-ba30bc6ab784	true	introspection.token.claim
814feb33-9207-4c6b-a333-ba30bc6ab784	true	userinfo.token.claim
814feb33-9207-4c6b-a333-ba30bc6ab784	middleName	user.attribute
814feb33-9207-4c6b-a333-ba30bc6ab784	true	id.token.claim
814feb33-9207-4c6b-a333-ba30bc6ab784	true	access.token.claim
814feb33-9207-4c6b-a333-ba30bc6ab784	middle_name	claim.name
814feb33-9207-4c6b-a333-ba30bc6ab784	String	jsonType.label
8dac19bc-449d-4f03-9503-156e33911885	true	introspection.token.claim
8dac19bc-449d-4f03-9503-156e33911885	true	userinfo.token.claim
8dac19bc-449d-4f03-9503-156e33911885	zoneinfo	user.attribute
8dac19bc-449d-4f03-9503-156e33911885	true	id.token.claim
8dac19bc-449d-4f03-9503-156e33911885	true	access.token.claim
8dac19bc-449d-4f03-9503-156e33911885	zoneinfo	claim.name
8dac19bc-449d-4f03-9503-156e33911885	String	jsonType.label
94c74d6a-ab8c-47cd-bc24-5368513d1a25	true	introspection.token.claim
94c74d6a-ab8c-47cd-bc24-5368513d1a25	true	userinfo.token.claim
94c74d6a-ab8c-47cd-bc24-5368513d1a25	gender	user.attribute
94c74d6a-ab8c-47cd-bc24-5368513d1a25	true	id.token.claim
94c74d6a-ab8c-47cd-bc24-5368513d1a25	true	access.token.claim
94c74d6a-ab8c-47cd-bc24-5368513d1a25	gender	claim.name
94c74d6a-ab8c-47cd-bc24-5368513d1a25	String	jsonType.label
a84867b2-d07a-4b51-adcd-ff201d6382d1	true	introspection.token.claim
a84867b2-d07a-4b51-adcd-ff201d6382d1	true	userinfo.token.claim
a84867b2-d07a-4b51-adcd-ff201d6382d1	firstName	user.attribute
a84867b2-d07a-4b51-adcd-ff201d6382d1	true	id.token.claim
a84867b2-d07a-4b51-adcd-ff201d6382d1	true	access.token.claim
a84867b2-d07a-4b51-adcd-ff201d6382d1	given_name	claim.name
a84867b2-d07a-4b51-adcd-ff201d6382d1	String	jsonType.label
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	true	introspection.token.claim
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	true	userinfo.token.claim
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	nickname	user.attribute
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	true	id.token.claim
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	true	access.token.claim
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	nickname	claim.name
c504a510-7f33-4e7d-8d59-ac3e45ca2f2e	String	jsonType.label
c71e27a4-7ded-4b71-9315-5f051ecbca8a	true	introspection.token.claim
c71e27a4-7ded-4b71-9315-5f051ecbca8a	true	userinfo.token.claim
c71e27a4-7ded-4b71-9315-5f051ecbca8a	updatedAt	user.attribute
c71e27a4-7ded-4b71-9315-5f051ecbca8a	true	id.token.claim
c71e27a4-7ded-4b71-9315-5f051ecbca8a	true	access.token.claim
c71e27a4-7ded-4b71-9315-5f051ecbca8a	updated_at	claim.name
c71e27a4-7ded-4b71-9315-5f051ecbca8a	long	jsonType.label
ca2d068c-6905-4c66-9f82-53ebe427a152	true	introspection.token.claim
ca2d068c-6905-4c66-9f82-53ebe427a152	true	userinfo.token.claim
ca2d068c-6905-4c66-9f82-53ebe427a152	locale	user.attribute
ca2d068c-6905-4c66-9f82-53ebe427a152	true	id.token.claim
ca2d068c-6905-4c66-9f82-53ebe427a152	true	access.token.claim
ca2d068c-6905-4c66-9f82-53ebe427a152	locale	claim.name
ca2d068c-6905-4c66-9f82-53ebe427a152	String	jsonType.label
d3be39da-9158-4584-bd65-9cd6d1ccdae1	true	introspection.token.claim
d3be39da-9158-4584-bd65-9cd6d1ccdae1	true	userinfo.token.claim
d3be39da-9158-4584-bd65-9cd6d1ccdae1	lastName	user.attribute
d3be39da-9158-4584-bd65-9cd6d1ccdae1	true	id.token.claim
d3be39da-9158-4584-bd65-9cd6d1ccdae1	true	access.token.claim
d3be39da-9158-4584-bd65-9cd6d1ccdae1	family_name	claim.name
d3be39da-9158-4584-bd65-9cd6d1ccdae1	String	jsonType.label
248cdf33-437d-4eca-890d-9ab2d2a274d2	true	introspection.token.claim
248cdf33-437d-4eca-890d-9ab2d2a274d2	true	userinfo.token.claim
248cdf33-437d-4eca-890d-9ab2d2a274d2	emailVerified	user.attribute
248cdf33-437d-4eca-890d-9ab2d2a274d2	true	id.token.claim
248cdf33-437d-4eca-890d-9ab2d2a274d2	true	access.token.claim
248cdf33-437d-4eca-890d-9ab2d2a274d2	email_verified	claim.name
248cdf33-437d-4eca-890d-9ab2d2a274d2	boolean	jsonType.label
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	true	introspection.token.claim
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	true	userinfo.token.claim
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	email	user.attribute
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	true	id.token.claim
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	true	access.token.claim
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	email	claim.name
5e618d02-6d1a-4e75-956b-3e92cb9e52bc	String	jsonType.label
a0633876-e43e-4819-b03f-a12520872b63	formatted	user.attribute.formatted
a0633876-e43e-4819-b03f-a12520872b63	country	user.attribute.country
a0633876-e43e-4819-b03f-a12520872b63	true	introspection.token.claim
a0633876-e43e-4819-b03f-a12520872b63	postal_code	user.attribute.postal_code
a0633876-e43e-4819-b03f-a12520872b63	true	userinfo.token.claim
a0633876-e43e-4819-b03f-a12520872b63	street	user.attribute.street
a0633876-e43e-4819-b03f-a12520872b63	true	id.token.claim
a0633876-e43e-4819-b03f-a12520872b63	region	user.attribute.region
a0633876-e43e-4819-b03f-a12520872b63	true	access.token.claim
a0633876-e43e-4819-b03f-a12520872b63	locality	user.attribute.locality
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	true	introspection.token.claim
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	true	userinfo.token.claim
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	phoneNumber	user.attribute
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	true	id.token.claim
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	true	access.token.claim
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	phone_number	claim.name
5b2ddf7a-9819-4b09-92be-b9c3fc6761ef	String	jsonType.label
cb624e65-8712-4fed-904d-a583bd081883	true	introspection.token.claim
cb624e65-8712-4fed-904d-a583bd081883	true	userinfo.token.claim
cb624e65-8712-4fed-904d-a583bd081883	phoneNumberVerified	user.attribute
cb624e65-8712-4fed-904d-a583bd081883	true	id.token.claim
cb624e65-8712-4fed-904d-a583bd081883	true	access.token.claim
cb624e65-8712-4fed-904d-a583bd081883	phone_number_verified	claim.name
cb624e65-8712-4fed-904d-a583bd081883	boolean	jsonType.label
01dd080a-201f-40d8-bc15-329d07db9354	true	introspection.token.claim
01dd080a-201f-40d8-bc15-329d07db9354	true	multivalued
01dd080a-201f-40d8-bc15-329d07db9354	foo	user.attribute
01dd080a-201f-40d8-bc15-329d07db9354	true	access.token.claim
01dd080a-201f-40d8-bc15-329d07db9354	realm_access.roles	claim.name
01dd080a-201f-40d8-bc15-329d07db9354	String	jsonType.label
12abdc6e-5ed5-4619-a2a4-af5f11324d35	true	introspection.token.claim
12abdc6e-5ed5-4619-a2a4-af5f11324d35	true	access.token.claim
bec2383e-3323-41b0-910a-17df493705be	true	introspection.token.claim
bec2383e-3323-41b0-910a-17df493705be	true	multivalued
bec2383e-3323-41b0-910a-17df493705be	foo	user.attribute
bec2383e-3323-41b0-910a-17df493705be	true	access.token.claim
bec2383e-3323-41b0-910a-17df493705be	resource_access.${client_id}.roles	claim.name
bec2383e-3323-41b0-910a-17df493705be	String	jsonType.label
0edcfd3d-5b5f-4cd4-9347-ab9a4dbe8dc6	true	introspection.token.claim
0edcfd3d-5b5f-4cd4-9347-ab9a4dbe8dc6	true	access.token.claim
3fa92378-6516-461f-8ae4-81cbb9205f9e	true	introspection.token.claim
3fa92378-6516-461f-8ae4-81cbb9205f9e	true	multivalued
3fa92378-6516-461f-8ae4-81cbb9205f9e	foo	user.attribute
3fa92378-6516-461f-8ae4-81cbb9205f9e	true	id.token.claim
3fa92378-6516-461f-8ae4-81cbb9205f9e	true	access.token.claim
3fa92378-6516-461f-8ae4-81cbb9205f9e	groups	claim.name
3fa92378-6516-461f-8ae4-81cbb9205f9e	String	jsonType.label
4ca58f5f-858b-4266-b499-2b10cb55c14c	true	introspection.token.claim
4ca58f5f-858b-4266-b499-2b10cb55c14c	true	userinfo.token.claim
4ca58f5f-858b-4266-b499-2b10cb55c14c	username	user.attribute
4ca58f5f-858b-4266-b499-2b10cb55c14c	true	id.token.claim
4ca58f5f-858b-4266-b499-2b10cb55c14c	true	access.token.claim
4ca58f5f-858b-4266-b499-2b10cb55c14c	upn	claim.name
4ca58f5f-858b-4266-b499-2b10cb55c14c	String	jsonType.label
c0b170d2-6b47-4328-a3ff-22aaf36471ec	true	introspection.token.claim
c0b170d2-6b47-4328-a3ff-22aaf36471ec	true	id.token.claim
c0b170d2-6b47-4328-a3ff-22aaf36471ec	true	access.token.claim
ea1f449c-e1c7-42b3-80b9-a110d2374800	true	id.token.claim
ea1f449c-e1c7-42b3-80b9-a110d2374800	true	introspection.token.claim
ea1f449c-e1c7-42b3-80b9-a110d2374800	true	access.token.claim
ea1f449c-e1c7-42b3-80b9-a110d2374800	true	userinfo.token.claim
de107bc2-78ce-4a9e-905b-b532204a5953	true	introspection.token.claim
de107bc2-78ce-4a9e-905b-b532204a5953	true	access.token.claim
dbf5d64d-cabb-4003-b02a-985414218672	formatted	user.attribute.formatted
dbf5d64d-cabb-4003-b02a-985414218672	country	user.attribute.country
dbf5d64d-cabb-4003-b02a-985414218672	true	introspection.token.claim
dbf5d64d-cabb-4003-b02a-985414218672	postal_code	user.attribute.postal_code
dbf5d64d-cabb-4003-b02a-985414218672	true	userinfo.token.claim
dbf5d64d-cabb-4003-b02a-985414218672	street	user.attribute.street
dbf5d64d-cabb-4003-b02a-985414218672	true	id.token.claim
dbf5d64d-cabb-4003-b02a-985414218672	region	user.attribute.region
dbf5d64d-cabb-4003-b02a-985414218672	true	access.token.claim
dbf5d64d-cabb-4003-b02a-985414218672	locality	user.attribute.locality
70b444c3-b57c-4ce1-a152-d306b0404f07	true	introspection.token.claim
70b444c3-b57c-4ce1-a152-d306b0404f07	true	userinfo.token.claim
70b444c3-b57c-4ce1-a152-d306b0404f07	username	user.attribute
70b444c3-b57c-4ce1-a152-d306b0404f07	true	id.token.claim
70b444c3-b57c-4ce1-a152-d306b0404f07	true	access.token.claim
70b444c3-b57c-4ce1-a152-d306b0404f07	upn	claim.name
70b444c3-b57c-4ce1-a152-d306b0404f07	String	jsonType.label
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	true	introspection.token.claim
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	true	multivalued
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	true	userinfo.token.claim
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	foo	user.attribute
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	true	id.token.claim
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	true	access.token.claim
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	groups	claim.name
ab4c9d99-27c8-49c8-b341-c2d5e3e5963d	String	jsonType.label
77c4580c-6a03-44e8-a26f-685bfc5ecabc	true	introspection.token.claim
77c4580c-6a03-44e8-a26f-685bfc5ecabc	true	multivalued
77c4580c-6a03-44e8-a26f-685bfc5ecabc	foo	user.attribute
77c4580c-6a03-44e8-a26f-685bfc5ecabc	true	access.token.claim
77c4580c-6a03-44e8-a26f-685bfc5ecabc	realm_access.roles	claim.name
77c4580c-6a03-44e8-a26f-685bfc5ecabc	String	jsonType.label
da37de35-ec78-4f9c-9829-5058ed440b15	true	introspection.token.claim
da37de35-ec78-4f9c-9829-5058ed440b15	true	access.token.claim
ef068605-d8db-4eef-8d28-83a1ab095d1b	true	introspection.token.claim
ef068605-d8db-4eef-8d28-83a1ab095d1b	true	multivalued
ef068605-d8db-4eef-8d28-83a1ab095d1b	foo	user.attribute
ef068605-d8db-4eef-8d28-83a1ab095d1b	true	access.token.claim
ef068605-d8db-4eef-8d28-83a1ab095d1b	resource_access.${client_id}.roles	claim.name
ef068605-d8db-4eef-8d28-83a1ab095d1b	String	jsonType.label
dfe19673-38de-4cc4-9a47-748e06683022	false	single
dfe19673-38de-4cc4-9a47-748e06683022	Basic	attribute.nameformat
dfe19673-38de-4cc4-9a47-748e06683022	Role	attribute.name
10813d4f-38e2-4dd1-b14d-81be46d0db3f	true	introspection.token.claim
10813d4f-38e2-4dd1-b14d-81be46d0db3f	true	userinfo.token.claim
10813d4f-38e2-4dd1-b14d-81be46d0db3f	emailVerified	user.attribute
10813d4f-38e2-4dd1-b14d-81be46d0db3f	true	id.token.claim
10813d4f-38e2-4dd1-b14d-81be46d0db3f	true	access.token.claim
10813d4f-38e2-4dd1-b14d-81be46d0db3f	email_verified	claim.name
10813d4f-38e2-4dd1-b14d-81be46d0db3f	boolean	jsonType.label
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	true	introspection.token.claim
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	true	userinfo.token.claim
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	email	user.attribute
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	true	id.token.claim
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	true	access.token.claim
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	email	claim.name
c3a03e87-2b23-40c1-b8a6-5532781f9d2a	String	jsonType.label
0de6ecac-82ff-44c2-b142-26bc5e103afc	true	introspection.token.claim
0de6ecac-82ff-44c2-b142-26bc5e103afc	true	userinfo.token.claim
0de6ecac-82ff-44c2-b142-26bc5e103afc	picture	user.attribute
0de6ecac-82ff-44c2-b142-26bc5e103afc	true	id.token.claim
0de6ecac-82ff-44c2-b142-26bc5e103afc	true	access.token.claim
0de6ecac-82ff-44c2-b142-26bc5e103afc	picture	claim.name
0de6ecac-82ff-44c2-b142-26bc5e103afc	String	jsonType.label
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	true	introspection.token.claim
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	true	userinfo.token.claim
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	profile	user.attribute
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	true	id.token.claim
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	true	access.token.claim
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	profile	claim.name
15b6f4bf-6bf7-4b5c-a18a-3794da5a6d23	String	jsonType.label
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	true	introspection.token.claim
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	true	userinfo.token.claim
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	website	user.attribute
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	true	id.token.claim
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	true	access.token.claim
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	website	claim.name
15cfa153-ecb8-4050-bbd6-d4d994ad37aa	String	jsonType.label
4834aa57-44e2-4b65-8418-7339460649fa	true	introspection.token.claim
4834aa57-44e2-4b65-8418-7339460649fa	true	userinfo.token.claim
4834aa57-44e2-4b65-8418-7339460649fa	username	user.attribute
4834aa57-44e2-4b65-8418-7339460649fa	true	id.token.claim
4834aa57-44e2-4b65-8418-7339460649fa	true	access.token.claim
4834aa57-44e2-4b65-8418-7339460649fa	preferred_username	claim.name
4834aa57-44e2-4b65-8418-7339460649fa	String	jsonType.label
4e761775-ad17-406c-994b-e786829142e6	true	introspection.token.claim
4e761775-ad17-406c-994b-e786829142e6	true	userinfo.token.claim
4e761775-ad17-406c-994b-e786829142e6	middleName	user.attribute
4e761775-ad17-406c-994b-e786829142e6	true	id.token.claim
4e761775-ad17-406c-994b-e786829142e6	true	access.token.claim
4e761775-ad17-406c-994b-e786829142e6	middle_name	claim.name
4e761775-ad17-406c-994b-e786829142e6	String	jsonType.label
547d7be4-05d5-49ad-a454-bbca71bba6e6	true	introspection.token.claim
547d7be4-05d5-49ad-a454-bbca71bba6e6	true	userinfo.token.claim
547d7be4-05d5-49ad-a454-bbca71bba6e6	lastName	user.attribute
547d7be4-05d5-49ad-a454-bbca71bba6e6	true	id.token.claim
547d7be4-05d5-49ad-a454-bbca71bba6e6	true	access.token.claim
547d7be4-05d5-49ad-a454-bbca71bba6e6	family_name	claim.name
547d7be4-05d5-49ad-a454-bbca71bba6e6	String	jsonType.label
649570ee-1422-499e-a383-52c3e3489918	true	introspection.token.claim
649570ee-1422-499e-a383-52c3e3489918	true	userinfo.token.claim
649570ee-1422-499e-a383-52c3e3489918	firstName	user.attribute
649570ee-1422-499e-a383-52c3e3489918	true	id.token.claim
649570ee-1422-499e-a383-52c3e3489918	true	access.token.claim
649570ee-1422-499e-a383-52c3e3489918	given_name	claim.name
649570ee-1422-499e-a383-52c3e3489918	String	jsonType.label
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	true	introspection.token.claim
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	true	userinfo.token.claim
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	locale	user.attribute
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	true	id.token.claim
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	true	access.token.claim
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	locale	claim.name
b3fcafcf-c4a1-43db-a671-d6620a92e5b1	String	jsonType.label
c55a0edf-364d-484b-a535-e14149d94f38	true	introspection.token.claim
c55a0edf-364d-484b-a535-e14149d94f38	true	userinfo.token.claim
c55a0edf-364d-484b-a535-e14149d94f38	zoneinfo	user.attribute
c55a0edf-364d-484b-a535-e14149d94f38	true	id.token.claim
c55a0edf-364d-484b-a535-e14149d94f38	true	access.token.claim
c55a0edf-364d-484b-a535-e14149d94f38	zoneinfo	claim.name
c55a0edf-364d-484b-a535-e14149d94f38	String	jsonType.label
c646f58d-2a9b-41f2-b2b6-3faf39dd5a7c	true	id.token.claim
c646f58d-2a9b-41f2-b2b6-3faf39dd5a7c	true	introspection.token.claim
c646f58d-2a9b-41f2-b2b6-3faf39dd5a7c	true	access.token.claim
c646f58d-2a9b-41f2-b2b6-3faf39dd5a7c	true	userinfo.token.claim
d6ef403a-94e4-4075-9b95-a110648b25df	true	introspection.token.claim
d6ef403a-94e4-4075-9b95-a110648b25df	true	userinfo.token.claim
d6ef403a-94e4-4075-9b95-a110648b25df	gender	user.attribute
d6ef403a-94e4-4075-9b95-a110648b25df	true	id.token.claim
d6ef403a-94e4-4075-9b95-a110648b25df	true	access.token.claim
d6ef403a-94e4-4075-9b95-a110648b25df	gender	claim.name
d6ef403a-94e4-4075-9b95-a110648b25df	String	jsonType.label
ef0b4467-f708-41a1-af98-5820c0e9eb5e	true	introspection.token.claim
ef0b4467-f708-41a1-af98-5820c0e9eb5e	true	userinfo.token.claim
ef0b4467-f708-41a1-af98-5820c0e9eb5e	nickname	user.attribute
ef0b4467-f708-41a1-af98-5820c0e9eb5e	true	id.token.claim
ef0b4467-f708-41a1-af98-5820c0e9eb5e	true	access.token.claim
ef0b4467-f708-41a1-af98-5820c0e9eb5e	nickname	claim.name
ef0b4467-f708-41a1-af98-5820c0e9eb5e	String	jsonType.label
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	true	introspection.token.claim
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	true	userinfo.token.claim
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	birthdate	user.attribute
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	true	id.token.claim
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	true	access.token.claim
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	birthdate	claim.name
f065d0a6-657f-4787-b6f4-7ce2ae3c1451	String	jsonType.label
fab4a40a-960a-4374-93b1-720fafe8d094	true	introspection.token.claim
fab4a40a-960a-4374-93b1-720fafe8d094	true	userinfo.token.claim
fab4a40a-960a-4374-93b1-720fafe8d094	updatedAt	user.attribute
fab4a40a-960a-4374-93b1-720fafe8d094	true	id.token.claim
fab4a40a-960a-4374-93b1-720fafe8d094	true	access.token.claim
fab4a40a-960a-4374-93b1-720fafe8d094	updated_at	claim.name
fab4a40a-960a-4374-93b1-720fafe8d094	long	jsonType.label
84219968-494f-4907-9b44-5b9a543abbee	true	introspection.token.claim
84219968-494f-4907-9b44-5b9a543abbee	true	userinfo.token.claim
84219968-494f-4907-9b44-5b9a543abbee	phoneNumberVerified	user.attribute
84219968-494f-4907-9b44-5b9a543abbee	true	id.token.claim
84219968-494f-4907-9b44-5b9a543abbee	true	access.token.claim
84219968-494f-4907-9b44-5b9a543abbee	phone_number_verified	claim.name
84219968-494f-4907-9b44-5b9a543abbee	boolean	jsonType.label
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	true	introspection.token.claim
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	true	userinfo.token.claim
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	phoneNumber	user.attribute
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	true	id.token.claim
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	true	access.token.claim
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	phone_number	claim.name
e546263d-92d7-4cd5-9626-1a0a0b2ee4a7	String	jsonType.label
72d733bd-eb8d-4b69-9cae-301072bb6b66	client_id	user.session.note
72d733bd-eb8d-4b69-9cae-301072bb6b66	true	introspection.token.claim
72d733bd-eb8d-4b69-9cae-301072bb6b66	true	id.token.claim
72d733bd-eb8d-4b69-9cae-301072bb6b66	true	access.token.claim
72d733bd-eb8d-4b69-9cae-301072bb6b66	client_id	claim.name
72d733bd-eb8d-4b69-9cae-301072bb6b66	String	jsonType.label
814d90ca-04c1-4cee-8bf9-68386c5b3639	clientAddress	user.session.note
814d90ca-04c1-4cee-8bf9-68386c5b3639	true	introspection.token.claim
814d90ca-04c1-4cee-8bf9-68386c5b3639	true	id.token.claim
814d90ca-04c1-4cee-8bf9-68386c5b3639	true	access.token.claim
814d90ca-04c1-4cee-8bf9-68386c5b3639	clientAddress	claim.name
814d90ca-04c1-4cee-8bf9-68386c5b3639	String	jsonType.label
a5b710d1-6b46-4e56-8335-0bfe0882dd75	clientHost	user.session.note
a5b710d1-6b46-4e56-8335-0bfe0882dd75	true	introspection.token.claim
a5b710d1-6b46-4e56-8335-0bfe0882dd75	true	userinfo.token.claim
a5b710d1-6b46-4e56-8335-0bfe0882dd75	true	id.token.claim
a5b710d1-6b46-4e56-8335-0bfe0882dd75	true	access.token.claim
a5b710d1-6b46-4e56-8335-0bfe0882dd75	clientHost	claim.name
a5b710d1-6b46-4e56-8335-0bfe0882dd75	String	jsonType.label
72d733bd-eb8d-4b69-9cae-301072bb6b66	true	userinfo.token.claim
814d90ca-04c1-4cee-8bf9-68386c5b3639	true	userinfo.token.claim
20448b0d-24e5-46a7-b451-51f4f1a5cafd	true	introspection.token.claim
20448b0d-24e5-46a7-b451-51f4f1a5cafd	true	userinfo.token.claim
20448b0d-24e5-46a7-b451-51f4f1a5cafd	locale	user.attribute
20448b0d-24e5-46a7-b451-51f4f1a5cafd	true	id.token.claim
20448b0d-24e5-46a7-b451-51f4f1a5cafd	true	access.token.claim
20448b0d-24e5-46a7-b451-51f4f1a5cafd	locale	claim.name
20448b0d-24e5-46a7-b451-51f4f1a5cafd	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	t	t	f	EXTERNAL	1800	36000	f	t	179a09f5-5f12-4ab7-812a-d47bb60745e4	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	88716f92-a2cf-4f1a-a4d3-fe1dc865674d	21243c6b-3795-4407-9f11-f3cd990a789b	ca8ad2ec-1f2b-43f2-aa49-ab209f8024ab	8957ed4b-6b0f-4185-9e60-464182460515	fbecc78b-5ecb-4911-b6d3-7d245c525bf4	2592000	f	900	t	f	cd8c6cbf-90b5-4b5e-bdfd-aca426a18277	0	f	0	0	fecc98c6-6655-4281-bdde-06e6fead3a63
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	60	300	900	keycloak.v3	keycloak.v2	keycloak	t	f	0	keycloak	RH-Realm	0	upperCase(1) and lowerCase(1) and digits(1) and notEmail(undefined) and notUsername(undefined) and specialChars(1) and length(8)	f	t	t	f	EXTERNAL	1800	28800	f	f	6cea6109-8f92-4041-8ccd-42c817d35904	1800	t	fr	t	f	f	f	0	1	30	6	HmacSHA1	totp	7e098704-19e7-4ee6-88dd-8a2e05c2d39a	59bd626e-fec5-4a2e-aeba-ce64f5aa40f3	8dd0b2ed-976d-4f2b-8218-0d7028f6f016	08a5c0a4-d929-41f0-bf60-fbe30ccda13f	2cfcd5a0-00dd-43ed-b332-8be33756f879	2592000	f	900	t	f	85e041ab-af74-4ef8-803d-591bc1c3559c	0	f	604800	13200	1b268c0e-9168-483e-b654-942ba25cb253
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
bruteForceProtected	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	false
permanentLockout	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	false
maxTemporaryLockouts	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	0
maxFailureWaitSeconds	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	900
minimumQuickLoginWaitSeconds	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	60
waitIncrementSeconds	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	60
quickLoginCheckMilliSeconds	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	1000
maxDeltaTimeSeconds	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	43200
failureFactor	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	30
realmReusableOtpCode	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	false
firstBrokerLoginFlowId	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	18241412-db05-4a68-aab2-bb6d23cf33a5
displayName	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	Keycloak
displayNameHtml	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	RS256
offlineSessionMaxLifespanEnabled	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	false
offlineSessionMaxLifespan	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	5184000
permanentLockout	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	false
maxTemporaryLockouts	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0
maxFailureWaitSeconds	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	900
minimumQuickLoginWaitSeconds	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	60
waitIncrementSeconds	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	60
quickLoginCheckMilliSeconds	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	1000
maxDeltaTimeSeconds	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	43200
realmReusableOtpCode	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	false
displayName	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	MYNDS_HR
displayNameHtml	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	MYNDS_HR
defaultSignatureAlgorithm	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	RS256
bruteForceProtected	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	true
failureFactor	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	3
_browser_header.contentSecurityPolicyReportOnly	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
_browser_header.xContentTypeOptions	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	nosniff
_browser_header.referrerPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	no-referrer
_browser_header.xRobotsTag	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	none
_browser_header.xFrameOptions	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	SAMEORIGIN
_browser_header.contentSecurityPolicy	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
offlineSessionMaxLifespanEnabled	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	false
offlineSessionMaxLifespan	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	5184000
clientSessionIdleTimeout	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0
clientSessionMaxLifespan	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0
clientOfflineSessionIdleTimeout	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0
clientOfflineSessionMaxLifespan	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0
actionTokenGeneratedByAdminLifespan	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	43200
actionTokenGeneratedByUserLifespan	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	300
oauth2DeviceCodeLifespan	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	600
oauth2DevicePollingInterval	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	5
webAuthnPolicyRpEntityName	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	keycloak
webAuthnPolicySignatureAlgorithms	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ES256
webAuthnPolicyRpId	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
webAuthnPolicyAttestationConveyancePreference	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
webAuthnPolicyAuthenticatorAttachment	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
webAuthnPolicyRequireResidentKey	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
webAuthnPolicyUserVerificationRequirement	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
webAuthnPolicyCreateTimeout	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0
webAuthnPolicyAvoidSameAuthenticatorRegister	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	false
webAuthnPolicyRpEntityNamePasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ES256
webAuthnPolicyRpIdPasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
webAuthnPolicyAttestationConveyancePreferencePasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
_browser_header.xXSSProtection	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	1; mode=block
_browser_header.strictTransportSecurity	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	max-age=31536000; includeSubDomains
webAuthnPolicyRequireResidentKeyPasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	not specified
webAuthnPolicyCreateTimeoutPasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	false
cibaBackchannelTokenDeliveryMode	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	poll
cibaExpiresIn	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	120
cibaInterval	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	5
cibaAuthRequestedUserHint	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	login_hint
parRequestUriLifespan	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	60
firstBrokerLoginFlowId	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	6c12061e-b841-4cea-8e0a-8aa3b520224f
actionTokenGeneratedByUserLifespan.verify-email	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
actionTokenGeneratedByUserLifespan.execute-actions	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
frontendUrl	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
acr.loa.map	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	{}
shortVerificationUri	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
actionTokenGeneratedByUserLifespan.reset-credentials	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	
client-policies.profiles	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	{"profiles":[]}
client-policies.policies	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	{"policies":[]}
cibaBackchannelTokenDeliveryMode	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	poll
cibaExpiresIn	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	120
cibaAuthRequestedUserHint	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	login_hint
parRequestUriLifespan	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	60
cibaInterval	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	5
actionTokenGeneratedByAdminLifespan	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	43200
actionTokenGeneratedByUserLifespan	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	300
oauth2DeviceCodeLifespan	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	600
oauth2DevicePollingInterval	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	5
clientSessionIdleTimeout	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	0
clientSessionMaxLifespan	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	0
clientOfflineSessionIdleTimeout	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	0
clientOfflineSessionMaxLifespan	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	0
webAuthnPolicyRpEntityName	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	keycloak
webAuthnPolicySignatureAlgorithms	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	ES256
webAuthnPolicyRpId	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	
webAuthnPolicyAttestationConveyancePreference	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyAuthenticatorAttachment	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyRequireResidentKey	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyUserVerificationRequirement	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyCreateTimeout	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	0
webAuthnPolicyAvoidSameAuthenticatorRegister	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	false
webAuthnPolicyRpEntityNamePasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	ES256
webAuthnPolicyRpIdPasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	
webAuthnPolicyAttestationConveyancePreferencePasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyRequireResidentKeyPasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	not specified
webAuthnPolicyCreateTimeoutPasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	false
client-policies.profiles	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	{"profiles":[]}
client-policies.policies	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	
_browser_header.xContentTypeOptions	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	nosniff
_browser_header.referrerPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	no-referrer
_browser_header.xRobotsTag	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	none
_browser_header.xFrameOptions	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	SAMEORIGIN
_browser_header.contentSecurityPolicy	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	1; mode=block
_browser_header.strictTransportSecurity	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	jboss-logging
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b
password	password	t	t	0ad55232-77dd-4fe6-bfc7-31fe24e318ad
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	Support Team	replyToDisplayName
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	true	starttls
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	true	auth
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	support@mynds-team.com	envelopeFrom
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	true	ssl
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	caot whfw fxcz xpba	password
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	465	port
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	smtp.gmail.com	host
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	support@mynds-team.com	replyTo
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	support@mynds-team.com	from
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	Mynds-team	fromDisplayName
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	dachraouia193@gmail.com	user
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ar
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	en
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	it
0ad55232-77dd-4fe6-bfc7-31fe24e318ad	fr
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.redirect_uris (client_id, value) FROM stdin;
c86c3790-9634-4fed-8575-f55be03be359	/realms/master/account/*
b55ec150-c0bd-4171-b469-a65da147094d	/realms/master/account/*
26ee6233-697d-43ff-bac9-31f7d2fce25f	/admin/master/console/*
29501232-33d4-45e4-b842-cd8ef4557d02	/realms/RH-Realm/account/*
9728a162-f8c8-4b53-91e2-cddcc88c8fd9	/realms/RH-Realm/account/*
151aede7-bfd9-481c-a55a-63cd79d17dbb	/*
19544a21-ea96-4619-9ce7-1eda3cd043c6	http://localhost:4200/assets/silent-check-sso.html
19544a21-ea96-4619-9ce7-1eda3cd043c6	http://localhost:4200/*
bf492b87-578b-4fde-b9bf-29832f852159	/admin/RH-Realm/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
eb9c4b34-4405-443e-8cd0-8f536d0facc0	VERIFY_EMAIL	Verify Email	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	VERIFY_EMAIL	50
8d3fa198-f705-43fc-a627-3c404ba81c92	UPDATE_PROFILE	Update Profile	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	UPDATE_PROFILE	40
68607189-a3a3-4412-b86f-8d5f2d971372	UPDATE_PASSWORD	Update Password	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	UPDATE_PASSWORD	30
0d4b7062-f689-4d87-b823-6e2b3d59fc09	TERMS_AND_CONDITIONS	Terms and Conditions	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f	f	TERMS_AND_CONDITIONS	20
de88f122-42ba-44d4-a416-1ef7f5f04580	delete_account	Delete Account	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	f	f	delete_account	60
72681d45-3d94-4a80-9235-c4776fb3cc93	update_user_locale	Update User Locale	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	update_user_locale	1000
8389507d-0e09-41e9-a153-4f9a168da4f3	webauthn-register	Webauthn Register	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	webauthn-register	70
035f8cad-8948-42a6-86cd-d7481cc52606	webauthn-register-passwordless	Webauthn Register Passwordless	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	webauthn-register-passwordless	80
b3ec2a9a-9a19-44e3-b268-0aa000d9d80c	VERIFY_PROFILE	Verify Profile	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	VERIFY_PROFILE	90
d71529e0-d999-42a9-89c2-910ef7f6e3e1	CONFIGURE_TOTP	Configure OTP	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	t	f	CONFIGURE_TOTP	10
41b9e265-49fa-43c5-95ef-0efef2c9e9b1	CONFIGURE_TOTP	Configure OTP	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	t	t	CONFIGURE_TOTP	10
076014a2-857a-4419-acb1-cd5af9fa74b7	TERMS_AND_CONDITIONS	Terms and Conditions	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	t	t	TERMS_AND_CONDITIONS	20
6e844b3a-0009-42a6-9cfe-9cced491dcbf	UPDATE_PASSWORD	Update Password	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	t	t	UPDATE_PASSWORD	30
f3e72bc9-5769-4994-b3bb-e3dd2470f910	UPDATE_PROFILE	Update Profile	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	f	UPDATE_PROFILE	40
9e366317-ef2d-46df-a3fd-a6eb9c9354d7	VERIFY_EMAIL	Verify Email	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	t	t	VERIFY_EMAIL	50
ec61f648-fe45-476c-89a2-19b37346595d	delete_account	Delete Account	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	f	delete_account	60
0aae0fa2-998e-40f5-8901-a4011b7554c5	webauthn-register	Webauthn Register	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	t	f	webauthn-register	70
866ccdef-be6c-4742-87b7-511870bdfe2b	VERIFY_PROFILE	Verify Profile	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	f	f	VERIFY_PROFILE	80
0f793dbf-5f69-40d4-9d28-4c1321b013a9	webauthn-register-passwordless	Webauthn Register Passwordless	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	t	f	webauthn-register-passwordless	90
cfdece4a-6090-437e-aa00-f759b1e55212	update_user_locale	Update User Locale	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: reunion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.reunion (id_reunion, date_debut, pv_reunion, sujet) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role (id_role, name) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_permission (id_role_permission, permission_id, role_id) FROM stdin;
\.


--
-- Data for Name: role_projet; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_projet (id_role_projet, nom_role) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
b55ec150-c0bd-4171-b469-a65da147094d	4bb702cf-a5ec-4698-90af-f00004e60ed2
b55ec150-c0bd-4171-b469-a65da147094d	4a7b202d-9b01-4f71-b751-4feea19213ad
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: tache; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tache (id_tache, description, statut, projet_id) FROM stdin;
\.


--
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ticket (id_ticket, description, statut, employee_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
terms_and_conditions	1743259720	5305b46a-f8b0-4575-ad24-f42edd85e298	2fe6be44-ecd8-462b-8e2c-c05090f8dd80	\N	\N	\N
locale	en	5305b46a-f8b0-4575-ad24-f42edd85e298	01287af9-a91d-427b-a25f-4e7fd53e79c4	\N	\N	\N
departmentId	5	8b78c864-0c62-45ae-826a-79e8c14ae442	e39389de-25b1-4308-98b5-82c635ff7c36	\N	\N	\N
cin	12345678	8b78c864-0c62-45ae-826a-79e8c14ae442	cbb41d76-c2eb-4cd7-bd52-fd31a00b577c	\N	\N	\N
salary	2000.0	8b78c864-0c62-45ae-826a-79e8c14ae442	279de444-546e-4bac-ab22-7d3e75a289f4	\N	\N	\N
departmentId	6	d265f826-6244-46aa-ac83-65eaf06edf23	342f71f6-09f4-4e28-ae17-e478fabbee9b	\N	\N	\N
cin	12345678	d265f826-6244-46aa-ac83-65eaf06edf23	5fce7dbc-141b-4768-af42-ec50ada71d57	\N	\N	\N
salary	3000.0	d265f826-6244-46aa-ac83-65eaf06edf23	5e2b979c-cb02-489c-afac-1ad6e134816f	\N	\N	\N
Hire_Date	2025-04-01	5305b46a-f8b0-4575-ad24-f42edd85e298	74b5b068-48c8-4237-b473-4c1ba3f70b56	\N	\N	\N
Hire_Date	2025-04-24	48e77e81-7a14-431a-af72-7c0c5c40d8f3	635a1c26-8ac2-49af-9790-4ba775d47bcf	\N	\N	\N
photoUrl	http://localhost:8083/uploads/1426d02f-d573-41b2-9d3f-eda7ae61682e.jpg	48e77e81-7a14-431a-af72-7c0c5c40d8f3	fc09fde6-571d-46aa-8c4b-7a244dc23efb	\N	\N	\N
photoUrl	http://localhost:8083/uploads/051d6c8a-b2bf-40ba-9079-7b283d21bca2.jpg	8d997418-b42e-44f6-beea-6712a948a535	98ca90cb-0ff3-401b-b6a6-b14bada5f0dd	\N	\N	\N
photoUrl	http://localhost:8083/uploads/8fe9f4c4-1fe1-4d98-8e7c-d83ee41a2ae9.jpg	d265f826-6244-46aa-ac83-65eaf06edf23	d89ee3bd-2a33-4b5a-bee0-ea89211ac89a	\N	\N	\N
photoUrl	http://localhost:8083/uploads/5b38bdc5-b0a9-4c86-a3d8-63a963076988.jpg	8b78c864-0c62-45ae-826a-79e8c14ae442	10df79d1-694f-4f7a-9a09-e6d547c0df25	\N	\N	\N
Hire_Date	2025-04-01	8b78c864-0c62-45ae-826a-79e8c14ae442	1681326d-a800-4915-a141-cab7eb6e3a55	\N	\N	\N
departmentId	6	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	708e30f3-f9e2-4cce-8eea-be33e8d72d83	\N	\N	\N
cin	123456789	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	00e0a12c-fbcd-44f5-adb1-7a80b02d42ca	\N	\N	\N
Gender	male	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	2c395737-024b-41d6-a954-d967861af75e	\N	\N	\N
salary	2000.0	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	22ee58b9-0d47-4155-8bfb-bfc27af7e618	\N	\N	\N
Material_Status	married	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	70390694-73d1-4f8a-9ec9-37deaa4078d9	\N	\N	\N
photoUrl	http://localhost:8083/uploads/18548c00-6d34-434a-b700-c9efdc6cab99.jpg	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	abbdba62-7356-48ee-81ae-92749c9e586d	\N	\N	\N
telephone	22568978	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	d2398631-9e6f-4d83-94dc-46708caafa22	\N	\N	\N
departmentId	5	d5801d06-6dce-4dce-9ff7-d212505caee3	d8895d5a-cd55-4c2c-85e2-20ecca1ea18f	\N	\N	\N
cin	12345678	d5801d06-6dce-4dce-9ff7-d212505caee3	57205f2d-bf63-488e-90a1-3d3da3201fb3	\N	\N	\N
photoUrl	http://localhost:8083/uploads/192feebf-a6f3-4e8a-921e-71a31601f885.jpg	d5801d06-6dce-4dce-9ff7-d212505caee3	9e46ed37-bdb1-42eb-826f-78189a606eee	\N	\N	\N
telephone	+216 2547836	d5801d06-6dce-4dce-9ff7-d212505caee3	43d58cb1-a57f-491b-a950-7a47f690361c	\N	\N	\N
salary	null	d5801d06-6dce-4dce-9ff7-d212505caee3	96bbf91b-1a59-42c6-99b6-db38ca00e537	\N	\N	\N
Hire_Date	04/01/2025	d5801d06-6dce-4dce-9ff7-d212505caee3	bf8280f5-fccd-4a4a-8efa-97457d8ea7c6	\N	\N	\N
departmentId	6	748218bf-e264-43cf-bfe8-9b36b036e8ff	82c81fa7-c139-4c22-a015-080de2ef7687	\N	\N	\N
cin	12345678	748218bf-e264-43cf-bfe8-9b36b036e8ff	501e4fc9-8204-4484-82a9-567b7fd91f11	\N	\N	\N
photoUrl	http://localhost:8083/uploads/fda8da81-9883-4d5d-87af-460248a41e1b.jpg	748218bf-e264-43cf-bfe8-9b36b036e8ff	5af677ea-7807-461f-8b60-da6c01c8d15c	\N	\N	\N
telephone	+216 25846982	748218bf-e264-43cf-bfe8-9b36b036e8ff	a0879068-ff0a-42cb-87ca-88b2e6c462cd	\N	\N	\N
Hire_Date	2025-04-01	d265f826-6244-46aa-ac83-65eaf06edf23	8c7e68e0-0994-45fc-a66a-2b547f3de611	\N	\N	\N
salary	null	748218bf-e264-43cf-bfe8-9b36b036e8ff	2b4fa40e-83aa-464f-ac45-0620315aeaed	\N	\N	\N
departmentId	5	8d997418-b42e-44f6-beea-6712a948a535	e5c102b6-98ec-4ed1-aaed-396a4f8aac6d	\N	\N	\N
cin	12345678	8d997418-b42e-44f6-beea-6712a948a535	fb7f5a7c-5eda-4927-91dc-3cd0dc73936e	\N	\N	\N
salary	2000.0	8d997418-b42e-44f6-beea-6712a948a535	cd831f61-7161-4406-8816-c57539aff86c	\N	\N	\N
ZIP	sdfdsf	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	1aef581c-322a-4240-a616-c951bd984cb1	\N	\N	\N
Mobile_Phone	sdfsdf	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	3c16b2ff-8d86-4b44-9636-aa56fa7e6251	\N	\N	\N
Birth_Date	2025-04-10	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	f1be7b29-ca50-4de9-abc9-6e9a7a381ca7	\N	\N	\N
Pay_Schedule	Semi-Monthly	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	2028bc08-c6f0-46cf-bcc1-47730c332cc0	\N	\N	\N
Hire_Date	2023-04-09	8d997418-b42e-44f6-beea-6712a948a535	e2a45988-e354-4935-8234-ee782ec32307	\N	\N	\N
departmentId	6	48e77e81-7a14-431a-af72-7c0c5c40d8f3	39c3604c-6bdb-4f77-ba1b-4ed149c2746e	\N	\N	\N
cin	12345678	48e77e81-7a14-431a-af72-7c0c5c40d8f3	591f34cf-391a-4b2b-9ffd-af383dd5ce2a	\N	\N	\N
salary	3000.0	48e77e81-7a14-431a-af72-7c0c5c40d8f3	9b76e504-f08d-4ced-bcf1-b039c891c6ff	\N	\N	\N
Pay_Type	Commission	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	0c629927-767b-403b-8bac-ad5597677295	\N	\N	\N
departmentId	6	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	a97e3bce-a406-4bca-8b81-c9efd502c76f	\N	\N	\N
cin	12345678	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	8da79dc1-48fa-4e08-b587-2fdd4b4ced28	\N	\N	\N
Gender	male	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	85cdb1e8-01d0-4eb5-8ef3-47080d99d537	\N	\N	\N
salary	3000.0	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	2be1c441-766a-4085-a8e1-f11e7a96b425	\N	\N	\N
Hire_Date	2025-04-03	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	db7170a9-b28f-4411-9e87-6761ea1e14ad	\N	\N	\N
Material_Status	single	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	b4953c22-f6f8-424d-ae65-b6297ae90d4b	\N	\N	\N
Work_Email	sdfsdf	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	7bb9dcd3-5a66-4bba-870b-d4a6f0768c1d	\N	\N	\N
ZIP	tunis	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	360a859d-2dc1-45a5-bb32-1e6b9c74b494	\N	\N	\N
Mobile_Phone	27568955	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	a2f831b3-0174-4dfb-bee2-a9e36847cbde	\N	\N	\N
Birth_Date	2025-04-10	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	3e323d44-522b-456c-8749-75ea31ca798e	\N	\N	\N
Pay_Schedule	Bi-Weekly	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	455eac28-e7c3-421a-8c92-30a21e8c811d	\N	\N	\N
Pay_Type	Commission	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	7a7ff804-2ae9-4d3a-ac97-0534d472187f	\N	\N	\N
departmentId	2	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	1d0c8d83-0383-48db-a4cc-09728f866254	\N	\N	\N
cin	12345678	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	f1d4576c-54bc-4372-8783-805ba140d7a0	\N	\N	\N
photoUrl	http://localhost:8083/uploads/2879dca3-e3c0-47ec-8c6e-741083e9dde2.jpg	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	6eedecf3-18f6-410b-8730-a4cb7fbcd189	\N	\N	\N
Work_Phone	sdfdsf	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	82c96ac1-97c3-47b3-ab69-c26ef0706c3f	\N	\N	\N
Street	dsfdsf	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	7b828008-9a03-494f-99de-8c0a1b1b16b8	\N	\N	\N
telephone	27937562	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	00de0d50-2dd4-4874-9a11-f6951e61b4b1	\N	\N	\N
City	dsfsdf	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	eef94478-28cb-47af-8fa6-d42ab36e9cfd	\N	\N	\N
Ethnicity	Mixed	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	bba960aa-7cc2-40ef-94a3-56a1b505ded3	\N	\N	\N
Country	Aruba	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	e48248a7-fd53-4545-9c36-0ae104714b0c	\N	\N	\N
Mobile_Phone	27937545	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	794be7ed-a73f-4c47-8a30-07ca57ae469d	\N	\N	\N
Pay_Schedule	Semi-Monthly	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	94a5bc81-c6da-48e1-8802-af36b353320e	\N	\N	\N
Pay_Type	Piece Rate	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	7ab60fde-2e59-4722-9d07-d75716689ad8	\N	\N	\N
departmentId	6	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	41a8c088-8eb1-4cc6-bc6a-bd65b00f76a6	\N	\N	\N
cin	12345678	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	e0e68ad9-740d-4ec7-a994-57123ae538b0	\N	\N	\N
Gender	male	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	da4f2f47-fa05-4ffe-b2dc-e8da747c8ccc	\N	\N	\N
salary	3000.0	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	c93ae2e2-58c2-4abe-bbd8-e80d006ad9f5	\N	\N	\N
Hire_Date	2025-04-03	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	39c72417-4783-4c04-9177-f263f681dbb2	\N	\N	\N
Work_Email	ahmed@gmail.com	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	030d293c-3ab6-4c5c-8a0a-4e0fa5ec2fba	\N	\N	\N
photoUrl	http://localhost:8083/uploads/91c3e9d1-6faa-41be-b610-7c7134a5f6a4.jpg	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	6a775ef7-0b21-455f-8052-7bb3c6f5befb	\N	\N	\N
Work_Phone	27937545	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	3d7e47ec-163d-4828-8e76-064985162406	\N	\N	\N
telephone	+216 4578795	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	c77adc21-a9ae-4da4-bf50-33ced18b585a	\N	\N	\N
Job_Title	user	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	c3bfb251-1e60-436c-bb91-33e27f68ad8c	\N	\N	\N
Ethnicity	Mixed	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	39e75408-92f5-4a64-9031-106a0471943a	\N	\N	\N
Country	American Samoa	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	dc2b60b5-a68c-48f1-902e-2c9e852b2507	\N	\N	\N
Location	tunis	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	df985761-c4aa-4561-abd1-605d203a6a0b	\N	\N	\N
Gender	male	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	c2d3af3d-b05f-4cf2-aa4e-12534612303b	\N	\N	\N
salary	3000.0	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	4d11e807-4e51-4d14-b0ca-14fdb29b9839	\N	\N	\N
Hire_Date	2025-04-09	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	a95b51f6-1417-42ab-bfdd-b754d285c3c7	\N	\N	\N
Material_Status	single	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	00bd7916-68fa-41b6-a346-8b904862e604	\N	\N	\N
Work_Email	dachraoui@gmail.com	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	bac42b44-c797-47b9-afae-32e72f556de5	\N	\N	\N
photoUrl	http://localhost:8083/uploads/de441261-a807-407f-ab01-926f45e13d78.jpg	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	1834ccdd-ef4f-4607-a481-83f8609e1b1d	\N	\N	\N
Work_Phone	27568955	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	34279904-8b81-424d-a683-0b1e7da0c36e	\N	\N	\N
Street	tunis 	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	090e7069-cef4-4eb0-9572-d7c3fbc30bd8	\N	\N	\N
telephone	+254 55878684	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	8596d0fd-504f-4577-8673-389ed52c046a	\N	\N	\N
City	tunis	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	97f8f810-6074-4d75-b190-2e34805a0663	\N	\N	\N
Job_Title	user	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	cb298b43-39d6-440e-8531-643b93bd78da	\N	\N	\N
Ethnicity	Hispanic/Latino	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	f92f00a4-5be0-4a2b-9e4f-44b8e58c8708	\N	\N	\N
Country	American Samoa	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	95d7f286-edcd-4e8c-a426-553bd04a5521	\N	\N	\N
Location	tunis	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	0ad125e0-59d0-41ef-b187-30030d97ee92	\N	\N	\N
cin	12345678	5305b46a-f8b0-4575-ad24-f42edd85e298	a62d4963-51a3-4b44-b3b4-f67378138788	\N	\N	\N
salary	3000.0	5305b46a-f8b0-4575-ad24-f42edd85e298	7d7b94dd-e574-4db0-8257-e129c77a54d1	\N	\N	\N
telephone	27584655	5305b46a-f8b0-4575-ad24-f42edd85e298	c8fab095-6ff9-4365-9954-77bcd11971e8	\N	\N	\N
ZIP	7100	36079834-cb68-4a4d-97fa-b1548bee3e9a	8bdb73ba-13e5-43f4-930b-bf623699935d	\N	\N	\N
Mobile_Phone	27845154	36079834-cb68-4a4d-97fa-b1548bee3e9a	3478e9cf-f09d-4d4a-84de-711a2307a4dc	\N	\N	\N
Birth_Date	2025-04-03	36079834-cb68-4a4d-97fa-b1548bee3e9a	5bfbe112-f9d0-4640-a7fb-42fcf47aabc7	\N	\N	\N
Pay_Schedule	Bi-Weekly	36079834-cb68-4a4d-97fa-b1548bee3e9a	974bd5b6-8765-4dad-9633-23f6c10cfa45	\N	\N	\N
Pay_Type	Commission	36079834-cb68-4a4d-97fa-b1548bee3e9a	43cd2261-589f-42d3-a2a9-a3dce31da39e	\N	\N	\N
departmentId	14	36079834-cb68-4a4d-97fa-b1548bee3e9a	aa6a10b4-10b1-4b24-aaff-96f8704fbb37	\N	\N	\N
cin	12345678	36079834-cb68-4a4d-97fa-b1548bee3e9a	1ca64813-97da-4c65-8d85-8dbd69239cbb	\N	\N	\N
Gender	male	36079834-cb68-4a4d-97fa-b1548bee3e9a	bf72317e-dde2-4815-8e02-2e4e13da90b5	\N	\N	\N
salary	3000.0	36079834-cb68-4a4d-97fa-b1548bee3e9a	b87dd0db-d595-4c81-b474-ab11db5245e4	\N	\N	\N
Hire_Date	2025-04-09	36079834-cb68-4a4d-97fa-b1548bee3e9a	999053e8-efe4-4103-a2c1-0f15d05839e6	\N	\N	\N
Material_Status	single	36079834-cb68-4a4d-97fa-b1548bee3e9a	7512f344-9b4f-448e-a2a0-2c34d485ed0b	\N	\N	\N
Work_Email	foufou@gmail.com	36079834-cb68-4a4d-97fa-b1548bee3e9a	65c152d6-7113-4974-ae98-9166f22a9576	\N	\N	\N
photoUrl	http://localhost:8083/uploads/8f842e93-c662-4b68-828f-cadd5e3aa243.jpg	36079834-cb68-4a4d-97fa-b1548bee3e9a	f9870dcb-697c-411b-8113-df4897ac65c4	\N	\N	\N
Work_Phone	27845154	36079834-cb68-4a4d-97fa-b1548bee3e9a	6f64ec31-c9a9-4bb3-a85c-b00e8b94f1e7	\N	\N	\N
Street	7100	36079834-cb68-4a4d-97fa-b1548bee3e9a	3ef2c76b-84f3-48ea-a24c-9678a1ffed97	\N	\N	\N
telephone	+215 4569855	36079834-cb68-4a4d-97fa-b1548bee3e9a	8f357db1-7b41-4047-80ad-81e0b3b6ac84	\N	\N	\N
City	7100	36079834-cb68-4a4d-97fa-b1548bee3e9a	f47a9920-3505-4f25-913f-8cf7ab39a455	\N	\N	\N
Job_Title	user	36079834-cb68-4a4d-97fa-b1548bee3e9a	40cb3aba-a4ce-4cc1-ae18-3154bcb92a2e	\N	\N	\N
Ethnicity	Caucasian	36079834-cb68-4a4d-97fa-b1548bee3e9a	625ce6b7-b434-4400-ac42-8ac82ba75be2	\N	\N	\N
Country	Cocos (Keeling) Islands	36079834-cb68-4a4d-97fa-b1548bee3e9a	a41b27e5-4b4b-4249-9881-575bce61c974	\N	\N	\N
Location	san betresberg	36079834-cb68-4a4d-97fa-b1548bee3e9a	baaa6326-5e30-4be0-808e-8928ce2ecc57	\N	\N	\N
Job_Title	user	5305b46a-f8b0-4575-ad24-f42edd85e298	6bd448cb-2dc2-4e4f-8f64-c2633b623e75	\N	\N	\N
departmentId	10	5305b46a-f8b0-4575-ad24-f42edd85e298	9663a32a-bb12-412a-8400-d120eb4086ea	\N	\N	\N
Birth_Date	2025-04-10	5305b46a-f8b0-4575-ad24-f42edd85e298	1c7b273e-2289-4e1c-9b0d-9e65b43b45b0	\N	\N	\N
Gender	Male	5305b46a-f8b0-4575-ad24-f42edd85e298	705c1bf9-5dd2-4b5b-863f-f64d09adfe87	\N	\N	\N
Pay_Type	3000	5305b46a-f8b0-4575-ad24-f42edd85e298	7097ff53-ebb3-4b82-a7e8-734d3fd4c18c	\N	\N	\N
Work_Phone	24578136	5305b46a-f8b0-4575-ad24-f42edd85e298	e0c74447-bec0-48d2-a3a0-595b9e3d78c7	\N	\N	\N
Street	4000	5305b46a-f8b0-4575-ad24-f42edd85e298	5c26b739-4639-4f3e-ba06-8c7fa0cd5275	\N	\N	\N
Country	tunisia	5305b46a-f8b0-4575-ad24-f42edd85e298	f2747292-1cee-4d06-a7cc-c17b1538307e	\N	\N	\N
Location	tunis	5305b46a-f8b0-4575-ad24-f42edd85e298	a1d94c74-ae49-44d1-80df-9df79badaa24	\N	\N	\N
Birth_Date	2025-04-03	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	0b8b3cb5-3b04-4636-bdc6-60d4b002ebaa	\N	\N	\N
Hire_Date	2025-04-10	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	4b023e02-73ef-4df9-8976-b71788b37563	\N	\N	\N
Pay_Type	Commission	38061f5a-68db-4e60-ae9f-681b2ae4c547	bc44ba0c-2885-4698-a711-6b1b5fe6f079	\N	\N	\N
departmentId	7	38061f5a-68db-4e60-ae9f-681b2ae4c547	ddcafd3b-3cda-4fb6-95a2-e1ba0a80738a	\N	\N	\N
cin	12345678	38061f5a-68db-4e60-ae9f-681b2ae4c547	9c5c7cb6-c1d0-4e5c-863a-7f0a218bb177	\N	\N	\N
salary	3000.0	38061f5a-68db-4e60-ae9f-681b2ae4c547	e72872af-5b13-4a46-8d0d-3d975a73f0c0	\N	\N	\N
photoUrl	http://localhost:8083/uploads/0ff7d84d-e35b-4742-817f-1a08f3cff899.jpg	38061f5a-68db-4e60-ae9f-681b2ae4c547	ac5f69f6-3f6f-495c-bb89-901e06a64d95	\N	\N	\N
telephone	+215 56655658	38061f5a-68db-4e60-ae9f-681b2ae4c547	3683373a-80aa-4cec-9927-1c66f993b501	\N	\N	\N
Country	Belize	38061f5a-68db-4e60-ae9f-681b2ae4c547	c6d1bf3a-fa05-4f1e-9d3c-c050e05c6cff	\N	\N	\N
terms_and_conditions	1744900675	38061f5a-68db-4e60-ae9f-681b2ae4c547	91318bde-1341-43d9-aa62-d5ec31c25377	\N	\N	\N
Material_Status	Married	5305b46a-f8b0-4575-ad24-f42edd85e298	7c205a36-b5dc-4586-a4ae-bed972293dba	\N	\N	\N
photoUrl	http://localhost:8083/uploads/6f1d652e-1c11-42bf-891d-bd5670ce5dcc.jpg	5305b46a-f8b0-4575-ad24-f42edd85e298	5cc916a2-c78f-4835-9229-a00b822ffdcd	\N	\N	\N
Hire_Date	2025-04-18	38061f5a-68db-4e60-ae9f-681b2ae4c547	67f52fd8-6972-4b5a-90b3-bff8c074b55e	\N	\N	\N
Hire_Date	2025-04-02	748218bf-e264-43cf-bfe8-9b36b036e8ff	31f040fd-9c00-455f-a1a9-3eef7fe02962	\N	\N	\N
ZIP	1234	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	d86f2a25-3874-400a-a905-4669dbe16557	\N	\N	\N
Mobile_Phone	48455255	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	e79d8599-a13d-438a-ab10-52949519171f	\N	\N	\N
Birth_Date	2025-04-10	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	02968055-6a1a-402a-b18a-24cfc157b452	\N	\N	\N
Pay_Schedule	Quarterly	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	a1a60894-9397-4d95-bfc5-4fc7ae381a73	\N	\N	\N
Pay_Type	Commission	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	a3a2f17a-f014-476f-ab10-b2f47d0ec72a	\N	\N	\N
departmentId	9	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	c56005cd-4ce0-4725-9b1a-f4f152033a93	\N	\N	\N
cin	12345678	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	b9433f47-3756-4ec6-87d5-2f9b30c9f2cf	\N	\N	\N
Gender	male	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	541cec11-45fc-4bad-8216-8faf6ff71a86	\N	\N	\N
salary	3000.0	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	0708284b-521c-45dc-a972-5a2f9fdb2f7c	\N	\N	\N
Hire_Date	2025-04-02	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	a15a239d-ab09-4aed-913d-303b057e49c4	\N	\N	\N
Material_Status	single	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	3618dd55-bf53-405e-a63b-9805a7049178	\N	\N	\N
Work_Email	dachraoui@gmail.com	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	3a35a342-64c1-41b0-8e08-ac72d650273f	\N	\N	\N
photoUrl	http://localhost:8083/uploads/705277f5-4cad-426e-96d7-7eef97cd2324.jpg	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	9b440213-357d-48ef-9c63-5f460b51f4bb	\N	\N	\N
Work_Phone	58758855	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	a1da219c-d236-4585-8116-89c917dcdb19	\N	\N	\N
Street	hbib themer	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	e8ad4401-a878-4a2b-8771-c9d89f614a4d	\N	\N	\N
telephone	+245 55858855	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	ff85b6b4-7592-4067-a876-2b5d1f3db576	\N	\N	\N
City	hbib themer	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	9a419065-7e29-44ee-ac4c-55b4c893de39	\N	\N	\N
Job_Title	user	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	a4c9c420-88da-447c-b4da-0350f43186fc	\N	\N	\N
Ethnicity	Hispanic/Latino	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	87f16d74-81d8-4ef5-b548-24e33cc37407	\N	\N	\N
Country	Angola	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	b28fc902-d16b-48f5-b5fc-abe4baf9f31d	\N	\N	\N
isArchived	false	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	22024ddf-4b65-410b-a319-4d10684e2bf1	\N	\N	\N
isArchived	false	48e77e81-7a14-431a-af72-7c0c5c40d8f3	fc10c562-57e9-43cc-9991-1079964388b4	\N	\N	\N
isArchived	true	748218bf-e264-43cf-bfe8-9b36b036e8ff	556683d0-b0c7-4f9e-b519-4f5c85f1673d	\N	\N	\N
isArchived	false	0558de05-3c7c-47d1-b8db-2cbc4c6774ce	92251ab5-98af-4548-a561-f86ac828ac7c	\N	\N	\N
isArchived	false	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	389ba57a-454d-4026-9bdd-373f680dce21	\N	\N	\N
isArchived	false	d5801d06-6dce-4dce-9ff7-d212505caee3	1af07d5b-b1f3-4ba5-96a2-ea1223d01b51	\N	\N	\N
locale	en	38061f5a-68db-4e60-ae9f-681b2ae4c547	6794b7f3-31e7-434c-a3a0-c0413d4a5b16	\N	\N	\N
Gender	Female	38061f5a-68db-4e60-ae9f-681b2ae4c547	fb399ec8-907f-4534-9cea-0364a6a8abab	\N	\N	\N
Material_Status	Single	38061f5a-68db-4e60-ae9f-681b2ae4c547	8a4d5e5c-ecae-4815-ba77-a9f707548484	\N	\N	\N
Location	tunis	38061f5a-68db-4e60-ae9f-681b2ae4c547	5a608aa8-951e-4add-b208-dfd360fbb489	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_department; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_department (id, user_id, department_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e4d83a00-a1f3-419f-9a8e-953012942eb4	\N	fc106e06-073f-4e1d-8d63-3fa5baef0461	f	t	\N	\N	\N	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	admin	1742577329167	\N	0
ec3d7043-bbc7-4801-a2aa-358b63fea108	dachraouia193@gmail.com	dachraouia193@gmail.com	t	t	\N	ahmed	dachraoui	2fd79542-5cfb-4b6d-8503-bce2b04a1e4b	ahmed	1742681325164	\N	0
e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	amen@gmail.com	amen@gmail.com	f	t	\N	ahmed	dachraoui	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	amen@gmail.com	1744585361403	\N	0
36079834-cb68-4a4d-97fa-b1548bee3e9a	dachraouia@gmail.com	dachraouia@gmail.com	f	t	\N	amin	amin	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	dachraouia@gmail.com	1744890460419	\N	0
f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	ahmed@gmail.com	ahmed@gmail.com	f	t	\N	ayoub	ayoub	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ahmed@gmail.com	1744728835977	\N	0
5305b46a-f8b0-4575-ad24-f42edd85e298	ahmed.dachraoui03@gmail.com	ahmed.dachraoui03@gmail.com	t	t	\N	ahmed	bouhmid	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ahmed.dachraoui03@gmail.com	1742682011192	\N	0
8b78c864-0c62-45ae-826a-79e8c14ae442	hou@gmail.com	hou@gmail.com	f	f	\N	ahmed	dachraoui	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	hou@gmail.com	1744497156932	\N	0
d265f826-6244-46aa-ac83-65eaf06edf23	ggg@gmail.com	ggg@gmail.com	f	f	\N	mohsen 	omar	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ggg@gmail.com	1744497377579	\N	0
8d997418-b42e-44f6-beea-6712a948a535	fffff@gmail.com	fffff@gmail.com	f	t	\N	dachraoui	ahmed	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	fffff@gmail.com	1744496062231	\N	0
a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	jeber@gmail.com	jeber@gmail.com	f	t	\N	jeber	jeber	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	jeber@gmail.com	1744983977813	\N	0
3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	saida@gmail.com	saida@gmail.com	f	f	\N	saida	saida	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	saida@gmail.com	1744802627265	\N	0
748218bf-e264-43cf-bfe8-9b36b036e8ff	ray@gmail.com	ray@gmail.com	f	f	\N	rayen	bon othmen	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	ray@gmail.com	1744639410427	\N	0
38061f5a-68db-4e60-ae9f-681b2ae4c547	dachraouia903@gmail.com	dachraouia903@gmail.com	t	t	\N	ahmed	ahmed	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	dachraouia903@gmail.com	1744900580663	\N	0
48e77e81-7a14-431a-af72-7c0c5c40d8f3	aziz@gmail.com	aziz@gmail.com	f	t	\N	ayoub	arfeoui	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	aziz@gmail.com	1744496947977	\N	0
0558de05-3c7c-47d1-b8db-2cbc4c6774ce	gggg@gmail.com	gggg@gmail.com	f	f	\N	ahmed	ahmed	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	gggg@gmail.com	1744729251524	\N	0
d5801d06-6dce-4dce-9ff7-d212505caee3	rami@gmail.com	rami@gmail.com	f	t	\N	rami	sassi	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	rami@gmail.com	1744632179994	\N	0
3f1787b5-3f86-44aa-b157-bd74f3c49e79	\N	10eacf8c-6a00-4368-8e35-c1e92aa0d614	f	t	\N	\N	\N	0ad55232-77dd-4fe6-bfc7-31fe24e318ad	service-account-keycloak-admin	1743461917862	151aede7-bfd9-481c-a55a-63cd79d17dbb	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
d265f826-6244-46aa-ac83-65eaf06edf23	CONFIGURE_TOTP
d265f826-6244-46aa-ac83-65eaf06edf23	TERMS_AND_CONDITIONS
d265f826-6244-46aa-ac83-65eaf06edf23	UPDATE_PASSWORD
d265f826-6244-46aa-ac83-65eaf06edf23	VERIFY_EMAIL
e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	CONFIGURE_TOTP
e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	TERMS_AND_CONDITIONS
e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	UPDATE_PASSWORD
e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c	VERIFY_EMAIL
d5801d06-6dce-4dce-9ff7-d212505caee3	CONFIGURE_TOTP
d5801d06-6dce-4dce-9ff7-d212505caee3	TERMS_AND_CONDITIONS
d5801d06-6dce-4dce-9ff7-d212505caee3	UPDATE_PASSWORD
d5801d06-6dce-4dce-9ff7-d212505caee3	VERIFY_EMAIL
e4d83a00-a1f3-419f-9a8e-953012942eb4	VERIFY_EMAIL
748218bf-e264-43cf-bfe8-9b36b036e8ff	CONFIGURE_TOTP
748218bf-e264-43cf-bfe8-9b36b036e8ff	TERMS_AND_CONDITIONS
748218bf-e264-43cf-bfe8-9b36b036e8ff	UPDATE_PASSWORD
748218bf-e264-43cf-bfe8-9b36b036e8ff	VERIFY_EMAIL
f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	CONFIGURE_TOTP
f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	TERMS_AND_CONDITIONS
f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	UPDATE_PASSWORD
f6d506b9-cafd-4f01-9bb8-1fa59aebf40c	VERIFY_EMAIL
0558de05-3c7c-47d1-b8db-2cbc4c6774ce	CONFIGURE_TOTP
0558de05-3c7c-47d1-b8db-2cbc4c6774ce	TERMS_AND_CONDITIONS
0558de05-3c7c-47d1-b8db-2cbc4c6774ce	UPDATE_PASSWORD
0558de05-3c7c-47d1-b8db-2cbc4c6774ce	VERIFY_EMAIL
3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	CONFIGURE_TOTP
3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	TERMS_AND_CONDITIONS
3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	UPDATE_PASSWORD
3e4d641a-ea32-4ed0-bcc5-2f0437c94c79	VERIFY_EMAIL
36079834-cb68-4a4d-97fa-b1548bee3e9a	CONFIGURE_TOTP
36079834-cb68-4a4d-97fa-b1548bee3e9a	TERMS_AND_CONDITIONS
36079834-cb68-4a4d-97fa-b1548bee3e9a	UPDATE_PASSWORD
36079834-cb68-4a4d-97fa-b1548bee3e9a	VERIFY_EMAIL
a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	CONFIGURE_TOTP
a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	TERMS_AND_CONDITIONS
a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	UPDATE_PASSWORD
a1946ba0-ad28-42fa-ae1d-12ba6bf3773b	VERIFY_EMAIL
8d997418-b42e-44f6-beea-6712a948a535	CONFIGURE_TOTP
8d997418-b42e-44f6-beea-6712a948a535	TERMS_AND_CONDITIONS
8d997418-b42e-44f6-beea-6712a948a535	UPDATE_PASSWORD
8d997418-b42e-44f6-beea-6712a948a535	VERIFY_EMAIL
48e77e81-7a14-431a-af72-7c0c5c40d8f3	CONFIGURE_TOTP
48e77e81-7a14-431a-af72-7c0c5c40d8f3	TERMS_AND_CONDITIONS
48e77e81-7a14-431a-af72-7c0c5c40d8f3	UPDATE_PASSWORD
48e77e81-7a14-431a-af72-7c0c5c40d8f3	VERIFY_EMAIL
8b78c864-0c62-45ae-826a-79e8c14ae442	CONFIGURE_TOTP
8b78c864-0c62-45ae-826a-79e8c14ae442	TERMS_AND_CONDITIONS
8b78c864-0c62-45ae-826a-79e8c14ae442	UPDATE_PASSWORD
8b78c864-0c62-45ae-826a-79e8c14ae442	VERIFY_EMAIL
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
fecc98c6-6655-4281-bdde-06e6fead3a63	e4d83a00-a1f3-419f-9a8e-953012942eb4
99ca1fb6-a6fb-434f-92b2-7432de3fca99	e4d83a00-a1f3-419f-9a8e-953012942eb4
1b268c0e-9168-483e-b654-942ba25cb253	5305b46a-f8b0-4575-ad24-f42edd85e298
626b1100-62ff-40ca-a8b5-1de304572b3d	5305b46a-f8b0-4575-ad24-f42edd85e298
fecc98c6-6655-4281-bdde-06e6fead3a63	ec3d7043-bbc7-4801-a2aa-358b63fea108
99ca1fb6-a6fb-434f-92b2-7432de3fca99	ec3d7043-bbc7-4801-a2aa-358b63fea108
420e0813-5169-4e75-bb9a-10c918d17d5c	ec3d7043-bbc7-4801-a2aa-358b63fea108
e3c526f4-1b7c-43a0-a3e6-4b27325fc16f	ec3d7043-bbc7-4801-a2aa-358b63fea108
1125526e-1dc4-4249-982e-fd555186d22c	ec3d7043-bbc7-4801-a2aa-358b63fea108
1b268c0e-9168-483e-b654-942ba25cb253	3f1787b5-3f86-44aa-b157-bd74f3c49e79
c4a21585-4646-401d-962d-4be453a1640f	3f1787b5-3f86-44aa-b157-bd74f3c49e79
9bc4ea09-73bf-4067-acbc-0f9736e15e5b	3f1787b5-3f86-44aa-b157-bd74f3c49e79
a4913c90-2930-410b-9284-77f1a6a07176	3f1787b5-3f86-44aa-b157-bd74f3c49e79
0f19e620-3caf-4a3b-9d66-8f9a0373f30d	3f1787b5-3f86-44aa-b157-bd74f3c49e79
b42fe5b5-3cd1-4545-a28c-bb2e21179896	3f1787b5-3f86-44aa-b157-bd74f3c49e79
4d10a48a-fdaa-4056-bee6-b8d11f515ab5	3f1787b5-3f86-44aa-b157-bd74f3c49e79
ae3bf6d7-1d00-42fb-b6ed-90b25b2aacee	3f1787b5-3f86-44aa-b157-bd74f3c49e79
96b45e07-8c72-441c-be73-dc193b2303bd	3f1787b5-3f86-44aa-b157-bd74f3c49e79
7c57ff83-ab57-4875-a750-ce52f5ee1d66	3f1787b5-3f86-44aa-b157-bd74f3c49e79
1bfcb7a9-9618-4f8f-b639-16133e3491db	3f1787b5-3f86-44aa-b157-bd74f3c49e79
5a7dfb38-2afb-4b45-a016-50c0ec190ffc	3f1787b5-3f86-44aa-b157-bd74f3c49e79
38fa1489-26fd-43a2-819e-898e2dae75fa	3f1787b5-3f86-44aa-b157-bd74f3c49e79
3851e009-525f-40ca-9d03-58130c900193	3f1787b5-3f86-44aa-b157-bd74f3c49e79
ec180aae-504e-43a6-abb0-33795dcb2c8f	3f1787b5-3f86-44aa-b157-bd74f3c49e79
614a6674-1104-40a4-b2fd-4fdc90473dd2	3f1787b5-3f86-44aa-b157-bd74f3c49e79
c9944b1b-bb51-45d8-905e-52346871b8f2	3f1787b5-3f86-44aa-b157-bd74f3c49e79
31981ce3-da19-4fe2-81b2-e66e6318dde8	3f1787b5-3f86-44aa-b157-bd74f3c49e79
1f3ffe01-1a9e-430c-9990-8441c87bc522	3f1787b5-3f86-44aa-b157-bd74f3c49e79
c40188ce-8726-4b5e-a191-74dabeb112ae	3f1787b5-3f86-44aa-b157-bd74f3c49e79
7e1330c4-eccc-45d3-8325-648991e598cf	3f1787b5-3f86-44aa-b157-bd74f3c49e79
8224e32b-ea3b-4d67-ab99-21aa4e27a85f	3f1787b5-3f86-44aa-b157-bd74f3c49e79
07f385e7-3e99-4655-8a00-89031babd21a	3f1787b5-3f86-44aa-b157-bd74f3c49e79
5e20a0bb-bf53-4bd3-a1fc-d9f88807082d	3f1787b5-3f86-44aa-b157-bd74f3c49e79
748a684a-7421-4d72-a435-0ff6ea824189	3f1787b5-3f86-44aa-b157-bd74f3c49e79
89c07c78-a781-4bd3-97c3-95309dde5765	3f1787b5-3f86-44aa-b157-bd74f3c49e79
d429ef84-ebb7-4f45-8e0c-dbc874ebe53d	3f1787b5-3f86-44aa-b157-bd74f3c49e79
7aee256b-b603-4d1f-a0c4-32043ee4f686	3f1787b5-3f86-44aa-b157-bd74f3c49e79
301f6caa-e28d-422d-9e5e-488e895826ce	3f1787b5-3f86-44aa-b157-bd74f3c49e79
6f8f04a0-abdd-413f-a4d4-9cf7ca53ab12	3f1787b5-3f86-44aa-b157-bd74f3c49e79
8cfcbda4-77ad-43c5-81aa-a72eb9ce2015	3f1787b5-3f86-44aa-b157-bd74f3c49e79
bc1f2c60-adf5-417a-a9f4-81b2fb364f78	ec3d7043-bbc7-4801-a2aa-358b63fea108
8ed72cd1-8049-4560-95d6-1d057e607822	ec3d7043-bbc7-4801-a2aa-358b63fea108
773f26ff-b20e-4c81-b072-0247282311aa	ec3d7043-bbc7-4801-a2aa-358b63fea108
c2f1026e-70ac-4a69-a97e-20f18065d199	ec3d7043-bbc7-4801-a2aa-358b63fea108
d32747e4-5764-48c0-9526-203530253b5b	ec3d7043-bbc7-4801-a2aa-358b63fea108
be3ce40c-1665-46f6-b99f-cbd06d41932c	ec3d7043-bbc7-4801-a2aa-358b63fea108
cc7b9c01-2bb3-419b-8856-a9fb217d6d54	ec3d7043-bbc7-4801-a2aa-358b63fea108
27bc7f62-0ebd-4094-983a-d936132b7018	ec3d7043-bbc7-4801-a2aa-358b63fea108
a1f7872e-cf74-463b-b06f-22f7fd47c954	ec3d7043-bbc7-4801-a2aa-358b63fea108
790f4901-7d58-4a1f-a71a-d689dd83bb94	ec3d7043-bbc7-4801-a2aa-358b63fea108
2cbfa34c-c32a-4704-89e6-013b87525351	ec3d7043-bbc7-4801-a2aa-358b63fea108
1e933c46-943a-4188-87c2-35a38f53be22	ec3d7043-bbc7-4801-a2aa-358b63fea108
1fe80e3f-bfd8-41ac-a221-8acf32fcff09	ec3d7043-bbc7-4801-a2aa-358b63fea108
f5130286-3c59-47e9-b17c-2085cb16302a	ec3d7043-bbc7-4801-a2aa-358b63fea108
89ebbb9d-81c6-48c1-aa1f-46a116b5029a	ec3d7043-bbc7-4801-a2aa-358b63fea108
c1c0546b-e8d5-4174-ba8e-04cb1d37cd1f	ec3d7043-bbc7-4801-a2aa-358b63fea108
ddeca923-8e80-4b44-872b-406a429176d7	ec3d7043-bbc7-4801-a2aa-358b63fea108
1b268c0e-9168-483e-b654-942ba25cb253	8d997418-b42e-44f6-beea-6712a948a535
b8e82c4f-e1de-4663-9cb9-b1aca6b4de98	8d997418-b42e-44f6-beea-6712a948a535
1b268c0e-9168-483e-b654-942ba25cb253	48e77e81-7a14-431a-af72-7c0c5c40d8f3
4daf7d76-2af4-4e0d-9c48-bff737ddb87f	48e77e81-7a14-431a-af72-7c0c5c40d8f3
1b268c0e-9168-483e-b654-942ba25cb253	8b78c864-0c62-45ae-826a-79e8c14ae442
b8e82c4f-e1de-4663-9cb9-b1aca6b4de98	8b78c864-0c62-45ae-826a-79e8c14ae442
1b268c0e-9168-483e-b654-942ba25cb253	d265f826-6244-46aa-ac83-65eaf06edf23
b8e82c4f-e1de-4663-9cb9-b1aca6b4de98	d265f826-6244-46aa-ac83-65eaf06edf23
1b268c0e-9168-483e-b654-942ba25cb253	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c
626b1100-62ff-40ca-a8b5-1de304572b3d	e2f36ce5-6ecb-45bb-aeb9-1f3a852fb88c
1b268c0e-9168-483e-b654-942ba25cb253	d5801d06-6dce-4dce-9ff7-d212505caee3
626b1100-62ff-40ca-a8b5-1de304572b3d	d5801d06-6dce-4dce-9ff7-d212505caee3
1b268c0e-9168-483e-b654-942ba25cb253	748218bf-e264-43cf-bfe8-9b36b036e8ff
626b1100-62ff-40ca-a8b5-1de304572b3d	748218bf-e264-43cf-bfe8-9b36b036e8ff
1b268c0e-9168-483e-b654-942ba25cb253	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c
b8e82c4f-e1de-4663-9cb9-b1aca6b4de98	f6d506b9-cafd-4f01-9bb8-1fa59aebf40c
1b268c0e-9168-483e-b654-942ba25cb253	0558de05-3c7c-47d1-b8db-2cbc4c6774ce
b8e82c4f-e1de-4663-9cb9-b1aca6b4de98	0558de05-3c7c-47d1-b8db-2cbc4c6774ce
1b268c0e-9168-483e-b654-942ba25cb253	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79
b8e82c4f-e1de-4663-9cb9-b1aca6b4de98	3e4d641a-ea32-4ed0-bcc5-2f0437c94c79
1b268c0e-9168-483e-b654-942ba25cb253	36079834-cb68-4a4d-97fa-b1548bee3e9a
626b1100-62ff-40ca-a8b5-1de304572b3d	36079834-cb68-4a4d-97fa-b1548bee3e9a
1b268c0e-9168-483e-b654-942ba25cb253	38061f5a-68db-4e60-ae9f-681b2ae4c547
1b268c0e-9168-483e-b654-942ba25cb253	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b
c7a0ea76-222f-4fe7-a405-272f19bca9cf	a1946ba0-ad28-42fa-ae1d-12ba6bf3773b
4daf7d76-2af4-4e0d-9c48-bff737ddb87f	38061f5a-68db-4e60-ae9f-681b2ae4c547
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.web_origins (client_id, value) FROM stdin;
26ee6233-697d-43ff-bac9-31f7d2fce25f	+
151aede7-bfd9-481c-a55a-63cd79d17dbb	/*
19544a21-ea96-4619-9ce7-1eda3cd043c6	*
bf492b87-578b-4fde-b9bf-29832f852159	+
\.


--
-- Name: condidat_id_condidat_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.condidat_id_condidat_seq', 1, false);


--
-- Name: conge_id_conge_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.conge_id_conge_seq', 1, false);


--
-- Name: contrat_id_contrat_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contrat_id_contrat_seq', 1, false);


--
-- Name: date_affectation_id_date_affectation_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.date_affectation_id_date_affectation_seq', 1, false);


--
-- Name: department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.department_id_seq', 15, true);


--
-- Name: document_id_demande_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.document_id_demande_doc_seq', 1, false);


--
-- Name: employee_id_employee_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.employee_id_employee_seq', 1, false);


--
-- Name: employee_projet_role_id_emp_projet_role_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.employee_projet_role_id_emp_projet_role_seq', 1, false);


--
-- Name: employee_reunion_id_emp_reunion_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.employee_reunion_id_emp_reunion_seq', 1, false);


--
-- Name: permission_id_permission_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.permission_id_permission_seq', 1, false);


--
-- Name: poste_id_poste_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.poste_id_poste_seq', 1, false);


--
-- Name: projet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.projet_id_seq', 1, false);


--
-- Name: reunion_id_reunion_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.reunion_id_reunion_seq', 1, false);


--
-- Name: role_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.role_id_role_seq', 1, false);


--
-- Name: role_permission_id_role_permission_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.role_permission_id_role_permission_seq', 1, false);


--
-- Name: role_projet_id_role_projet_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.role_projet_id_role_projet_seq', 1, false);


--
-- Name: tache_id_tache_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.tache_id_tache_seq', 1, false);


--
-- Name: ticket_id_ticket_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ticket_id_ticket_seq', 1, false);


--
-- Name: user_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_department_id_seq', 1, false);


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: condidat condidat_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.condidat
    ADD CONSTRAINT condidat_pkey PRIMARY KEY (id_condidat);


--
-- Name: conge conge_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conge
    ADD CONSTRAINT conge_pkey PRIMARY KEY (id_conge);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: contrat contrat_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contrat
    ADD CONSTRAINT contrat_pkey PRIMARY KEY (id_contrat);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: date_affectation date_affectation_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.date_affectation
    ADD CONSTRAINT date_affectation_pkey PRIMARY KEY (id_date_affectation);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: document document_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT document_pkey PRIMARY KEY (id_demande_doc);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id_employee);


--
-- Name: employee_projet_role employee_projet_role_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_projet_role
    ADD CONSTRAINT employee_projet_role_pkey PRIMARY KEY (id_emp_projet_role);


--
-- Name: employee_reunion employee_reunion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_reunion
    ADD CONSTRAINT employee_reunion_pkey PRIMARY KEY (id_emp_reunion);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id_permission);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: poste poste_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_pkey PRIMARY KEY (id_poste);


--
-- Name: projet projet_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.projet
    ADD CONSTRAINT projet_pkey PRIMARY KEY (id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: reunion reunion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reunion
    ADD CONSTRAINT reunion_pkey PRIMARY KEY (id_reunion);


--
-- Name: role_permission role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (id_role_permission);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id_role);


--
-- Name: role_projet role_projet_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_projet
    ADD CONSTRAINT role_projet_pkey PRIMARY KEY (id_role_projet);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: tache tache_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tache
    ADD CONSTRAINT tache_pkey PRIMARY KEY (id_tache);


--
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (id_ticket);


--
-- Name: permission uk2ojme20jpga3r4r79tdso17gi; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT uk2ojme20jpga3r4r79tdso17gi UNIQUE (name);


--
-- Name: role uk8sewwnpamngi6b1dwaa88askk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT uk8sewwnpamngi6b1dwaa88askk UNIQUE (name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: employee ukfopic1oh5oln2khj8eat6ino0; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT ukfopic1oh5oln2khj8eat6ino0 UNIQUE (email);


--
-- Name: user_department user_department_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_department
    ADD CONSTRAINT user_department_pkey PRIMARY KEY (id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: employee fk3046kvjyysq288vy3lsbtc9nw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk3046kvjyysq288vy3lsbtc9nw FOREIGN KEY (role_id) REFERENCES public.role(id_role);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: employee_reunion fk4yn5ppjbmv005yn7tyt51qqkp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_reunion
    ADD CONSTRAINT fk4yn5ppjbmv005yn7tyt51qqkp FOREIGN KEY (reunion_id) REFERENCES public.reunion(id_reunion);


--
-- Name: employee_projet_role fk5c5yo0hk3so3qrvsg7mvkf781; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_projet_role
    ADD CONSTRAINT fk5c5yo0hk3so3qrvsg7mvkf781 FOREIGN KEY (projet_id) REFERENCES public.projet(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: role_permission fka6jx8n8xkesmjmv6jqug6bg68; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fka6jx8n8xkesmjmv6jqug6bg68 FOREIGN KEY (role_id) REFERENCES public.role(id_role);


--
-- Name: ticket fka78dsu86la2dni050sh6gap19; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fka78dsu86la2dni050sh6gap19 FOREIGN KEY (employee_id) REFERENCES public.employee(id_employee);


--
-- Name: employee fkbejtwvg9bxus2mffsm3swj3u9; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fkbejtwvg9bxus2mffsm3swj3u9 FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: role_permission fkf8yllw1ecvwqy3ehyxawqa1qp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT fkf8yllw1ecvwqy3ehyxawqa1qp FOREIGN KEY (permission_id) REFERENCES public.permission(id_permission);


--
-- Name: tache fkf97vcdrmyltn9s75dgh2tlw70; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tache
    ADD CONSTRAINT fkf97vcdrmyltn9s75dgh2tlw70 FOREIGN KEY (projet_id) REFERENCES public.projet(id);


--
-- Name: user_department fkh9wprwvoo5il7qqahjc7hgcax; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_department
    ADD CONSTRAINT fkh9wprwvoo5il7qqahjc7hgcax FOREIGN KEY (department_id) REFERENCES public.department(id);


--
-- Name: employee_projet_role fknf30573u739pm4h1o0u685kwg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_projet_role
    ADD CONSTRAINT fknf30573u739pm4h1o0u685kwg FOREIGN KEY (employee_id) REFERENCES public.employee(id_employee);


--
-- Name: date_affectation fkntnqjlku7aq88g9khpoxj6f29; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.date_affectation
    ADD CONSTRAINT fkntnqjlku7aq88g9khpoxj6f29 FOREIGN KEY (tache_id) REFERENCES public.tache(id_tache);


--
-- Name: date_affectation fkot9ka91gp4wjfiupso5r491uf; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.date_affectation
    ADD CONSTRAINT fkot9ka91gp4wjfiupso5r491uf FOREIGN KEY (employee_id) REFERENCES public.employee(id_employee);


--
-- Name: employee_projet_role fksvhcw9dma005f1dyflnapad6u; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_projet_role
    ADD CONSTRAINT fksvhcw9dma005f1dyflnapad6u FOREIGN KEY (projet_role_id) REFERENCES public.role_projet(id_role_projet);


--
-- Name: employee_reunion fkt89m0geew9m9n813e2tf2c9bc; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee_reunion
    ADD CONSTRAINT fkt89m0geew9m9n813e2tf2c9bc FOREIGN KEY (employee_id) REFERENCES public.employee(id_employee);


--
-- PostgreSQL database dump complete
--

