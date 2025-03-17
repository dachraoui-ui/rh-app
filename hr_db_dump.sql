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
    resource_type character varying(64),
    details_json text
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
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO admin;

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
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
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
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO admin;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
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
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
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
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO admin;

--
-- Name: org; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO admin;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO admin;

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
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO admin;

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
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
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

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
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
d8717014-bb46-46df-be43-c18621ff7ad3	\N	auth-cookie	5000cf22-fc94-4d79-8942-f7e575263547	5114eaf6-20f1-488e-bddb-5d1705482083	2	10	f	\N	\N
ede6ed4b-ab36-4d59-9780-36510a086e88	\N	auth-spnego	5000cf22-fc94-4d79-8942-f7e575263547	5114eaf6-20f1-488e-bddb-5d1705482083	3	20	f	\N	\N
43ba172f-301d-43d6-b9d4-9517664c1301	\N	identity-provider-redirector	5000cf22-fc94-4d79-8942-f7e575263547	5114eaf6-20f1-488e-bddb-5d1705482083	2	25	f	\N	\N
8d039376-d097-458c-9217-0262d1aff2bf	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	5114eaf6-20f1-488e-bddb-5d1705482083	2	30	t	6253d3ee-4229-4e44-a78f-e0d3ef7b7277	\N
8a930cc6-0e7f-4783-bd33-31ee3bf1e165	\N	auth-username-password-form	5000cf22-fc94-4d79-8942-f7e575263547	6253d3ee-4229-4e44-a78f-e0d3ef7b7277	0	10	f	\N	\N
a3a44ed8-6f96-4f8f-a40a-0a744a0ac1ea	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	6253d3ee-4229-4e44-a78f-e0d3ef7b7277	1	20	t	223f5411-a278-4cb3-bc51-40f2ab17ad16	\N
ca1a1c52-e58c-498e-8f00-d59edd8aeca0	\N	conditional-user-configured	5000cf22-fc94-4d79-8942-f7e575263547	223f5411-a278-4cb3-bc51-40f2ab17ad16	0	10	f	\N	\N
28f755c4-d2c1-450a-a430-0f88c7cf4252	\N	auth-otp-form	5000cf22-fc94-4d79-8942-f7e575263547	223f5411-a278-4cb3-bc51-40f2ab17ad16	0	20	f	\N	\N
a345f0f0-9083-4d1d-b62b-fbc7042ce77b	\N	direct-grant-validate-username	5000cf22-fc94-4d79-8942-f7e575263547	58f043c9-662d-4d91-939a-0a1f9573af25	0	10	f	\N	\N
9c869b90-eef9-4cef-939f-761d06c2115d	\N	direct-grant-validate-password	5000cf22-fc94-4d79-8942-f7e575263547	58f043c9-662d-4d91-939a-0a1f9573af25	0	20	f	\N	\N
be994360-ecbd-4a8a-98de-b4fdbec7470b	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	58f043c9-662d-4d91-939a-0a1f9573af25	1	30	t	e6fc7281-83a9-4b25-8838-2640d943dd5d	\N
7bc9e0d6-fa67-41a3-83a1-b6d8d528f51e	\N	conditional-user-configured	5000cf22-fc94-4d79-8942-f7e575263547	e6fc7281-83a9-4b25-8838-2640d943dd5d	0	10	f	\N	\N
daebbf89-8d40-4ad9-8a94-b180b7f34f23	\N	direct-grant-validate-otp	5000cf22-fc94-4d79-8942-f7e575263547	e6fc7281-83a9-4b25-8838-2640d943dd5d	0	20	f	\N	\N
86092f05-ae99-4dad-90c7-293e924d38de	\N	registration-page-form	5000cf22-fc94-4d79-8942-f7e575263547	eb3669ec-0dcd-4626-94cc-4f05eeb78b88	0	10	t	4f418771-ca78-46a7-a1fe-c1be6738cb19	\N
352a3dde-30ca-45a0-9324-0650083bf7b6	\N	registration-user-creation	5000cf22-fc94-4d79-8942-f7e575263547	4f418771-ca78-46a7-a1fe-c1be6738cb19	0	20	f	\N	\N
c0d865de-d688-46a3-8eeb-aab500ba4c34	\N	registration-password-action	5000cf22-fc94-4d79-8942-f7e575263547	4f418771-ca78-46a7-a1fe-c1be6738cb19	0	50	f	\N	\N
6582bd13-ff08-44db-a074-bf4d04f8f605	\N	registration-recaptcha-action	5000cf22-fc94-4d79-8942-f7e575263547	4f418771-ca78-46a7-a1fe-c1be6738cb19	3	60	f	\N	\N
b24981f1-20b7-47b8-a4f7-307fffced63e	\N	registration-terms-and-conditions	5000cf22-fc94-4d79-8942-f7e575263547	4f418771-ca78-46a7-a1fe-c1be6738cb19	3	70	f	\N	\N
38c6a0bc-7148-41dc-b279-d99b87d8ca4f	\N	reset-credentials-choose-user	5000cf22-fc94-4d79-8942-f7e575263547	2453e655-9434-40ad-9cda-8cd6e566f858	0	10	f	\N	\N
66306b29-b49a-46bb-8f5d-0ef6bbfe84a0	\N	reset-credential-email	5000cf22-fc94-4d79-8942-f7e575263547	2453e655-9434-40ad-9cda-8cd6e566f858	0	20	f	\N	\N
7da78bf3-4874-43a3-af18-9a0f637b40df	\N	reset-password	5000cf22-fc94-4d79-8942-f7e575263547	2453e655-9434-40ad-9cda-8cd6e566f858	0	30	f	\N	\N
a1e4042c-e6df-4e42-bbfb-8ddf5815f2e4	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	2453e655-9434-40ad-9cda-8cd6e566f858	1	40	t	54193694-da3d-4dac-a7a1-255470569b8a	\N
88bdff2d-f7ae-407d-9925-64c18db96c3a	\N	conditional-user-configured	5000cf22-fc94-4d79-8942-f7e575263547	54193694-da3d-4dac-a7a1-255470569b8a	0	10	f	\N	\N
d05ea977-d1b6-4ed3-8d26-c0918d9f109f	\N	reset-otp	5000cf22-fc94-4d79-8942-f7e575263547	54193694-da3d-4dac-a7a1-255470569b8a	0	20	f	\N	\N
80f519a2-808c-48e5-99c2-507baf726028	\N	client-secret	5000cf22-fc94-4d79-8942-f7e575263547	edb809e4-e720-437f-be71-4153caa3306e	2	10	f	\N	\N
37ad00db-f35e-49c9-8232-6c2083417c1d	\N	client-jwt	5000cf22-fc94-4d79-8942-f7e575263547	edb809e4-e720-437f-be71-4153caa3306e	2	20	f	\N	\N
0199b9e7-1f15-4f2a-a52e-56038b4d8f57	\N	client-secret-jwt	5000cf22-fc94-4d79-8942-f7e575263547	edb809e4-e720-437f-be71-4153caa3306e	2	30	f	\N	\N
dbe0d8ec-c7f7-4dc4-9be1-fb2e5049cc36	\N	client-x509	5000cf22-fc94-4d79-8942-f7e575263547	edb809e4-e720-437f-be71-4153caa3306e	2	40	f	\N	\N
fcd8c851-6c8b-4a55-abba-395aa3878680	\N	idp-review-profile	5000cf22-fc94-4d79-8942-f7e575263547	36e8b7cb-3d27-43c3-9405-26ee99b59a01	0	10	f	\N	c714c680-d725-461a-8362-2b80933d81bf
247176f0-cdca-4ac9-adb5-2399bc09d301	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	36e8b7cb-3d27-43c3-9405-26ee99b59a01	0	20	t	e9b308f7-7f9b-4937-849c-efacca50aa0c	\N
5d33e0a8-5d55-41ed-9f8d-15623edd60ab	\N	idp-create-user-if-unique	5000cf22-fc94-4d79-8942-f7e575263547	e9b308f7-7f9b-4937-849c-efacca50aa0c	2	10	f	\N	c63b8a45-3792-4464-abc5-81634cddc722
59709e46-9ce8-46d6-881d-44d375c9bac6	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	e9b308f7-7f9b-4937-849c-efacca50aa0c	2	20	t	b8c50f97-39a8-489c-937b-2da59548c7c7	\N
28094110-a6be-43ba-89d0-d85f98599c91	\N	idp-confirm-link	5000cf22-fc94-4d79-8942-f7e575263547	b8c50f97-39a8-489c-937b-2da59548c7c7	0	10	f	\N	\N
7e061e87-7401-4ea3-b8a7-14fcd7710dfa	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	b8c50f97-39a8-489c-937b-2da59548c7c7	0	20	t	f7752795-8aac-410a-afce-3a0264b90296	\N
7e6b458d-976b-48f3-965e-dfa242d3bb63	\N	idp-email-verification	5000cf22-fc94-4d79-8942-f7e575263547	f7752795-8aac-410a-afce-3a0264b90296	2	10	f	\N	\N
cccbe735-3366-4381-9206-dc538eb740ef	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	f7752795-8aac-410a-afce-3a0264b90296	2	20	t	a866c5f7-d6b9-47c7-87e0-a9016d1a8366	\N
01fc9a56-b1c7-4e37-ab98-dc6f98316c90	\N	idp-username-password-form	5000cf22-fc94-4d79-8942-f7e575263547	a866c5f7-d6b9-47c7-87e0-a9016d1a8366	0	10	f	\N	\N
e1d0b607-f4c5-41f2-b515-0dfb9c3b3c22	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	a866c5f7-d6b9-47c7-87e0-a9016d1a8366	1	20	t	116ce65f-4249-4540-a61f-b392f957551e	\N
ae863253-f3f6-4e79-af7a-7754b40b3bd3	\N	conditional-user-configured	5000cf22-fc94-4d79-8942-f7e575263547	116ce65f-4249-4540-a61f-b392f957551e	0	10	f	\N	\N
2141ea29-303f-4447-a6d1-726da712ff65	\N	auth-otp-form	5000cf22-fc94-4d79-8942-f7e575263547	116ce65f-4249-4540-a61f-b392f957551e	0	20	f	\N	\N
e596c00a-fafe-483f-b340-0e0b31ec1f7e	\N	http-basic-authenticator	5000cf22-fc94-4d79-8942-f7e575263547	cbdd79a0-85cc-4f3a-9278-f2a1c502568b	0	10	f	\N	\N
637fb5d3-7ed8-430c-b730-e58769f0efc1	\N	docker-http-basic-authenticator	5000cf22-fc94-4d79-8942-f7e575263547	bf7cbaf8-a205-4991-9be8-dbae7e397b03	0	10	f	\N	\N
5bf34bf8-5484-49e6-a246-3c9040b75917	\N	auth-cookie	64ff6a29-5a1a-4538-bfe4-ab59163e838a	8591a9b7-ffca-4e63-9517-8155111430e2	2	10	f	\N	\N
55ea44e1-5f45-4672-8f96-38022ed196ea	\N	auth-spnego	64ff6a29-5a1a-4538-bfe4-ab59163e838a	8591a9b7-ffca-4e63-9517-8155111430e2	3	20	f	\N	\N
485550ce-97c8-4d2b-9852-96ad6612c0a5	\N	identity-provider-redirector	64ff6a29-5a1a-4538-bfe4-ab59163e838a	8591a9b7-ffca-4e63-9517-8155111430e2	2	25	f	\N	\N
2127628c-eb9f-4549-9001-f6d4111ba567	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	8591a9b7-ffca-4e63-9517-8155111430e2	2	30	t	f18843b7-f97f-4e38-ab71-75b055de2d84	\N
d713c540-8d86-4ea8-8153-373836f08505	\N	auth-username-password-form	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f18843b7-f97f-4e38-ab71-75b055de2d84	0	10	f	\N	\N
d6b5e693-89f9-4850-9612-0d12316654e7	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f18843b7-f97f-4e38-ab71-75b055de2d84	1	20	t	73db2223-001d-49fb-ad62-29c6a56c5d05	\N
9f662ce2-78e9-4535-a9b6-2b7c57cb18aa	\N	conditional-user-configured	64ff6a29-5a1a-4538-bfe4-ab59163e838a	73db2223-001d-49fb-ad62-29c6a56c5d05	0	10	f	\N	\N
597003a1-88e8-44f0-aede-f76c8004fbd0	\N	auth-otp-form	64ff6a29-5a1a-4538-bfe4-ab59163e838a	73db2223-001d-49fb-ad62-29c6a56c5d05	0	20	f	\N	\N
4d415ccd-56da-4e94-8c31-c3e9aa1d0ce1	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	8591a9b7-ffca-4e63-9517-8155111430e2	2	26	t	75e9d796-a82e-4cb4-a4b5-bd556b138a2f	\N
1d57de26-2e95-4e8c-b52d-e26ae0bd5057	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	75e9d796-a82e-4cb4-a4b5-bd556b138a2f	1	10	t	ba83eb89-1707-4acd-a6c1-a7657ac811da	\N
81a303dd-14e2-49dc-9d52-bc1ee9376b9e	\N	conditional-user-configured	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ba83eb89-1707-4acd-a6c1-a7657ac811da	0	10	f	\N	\N
dffff53b-ae95-443b-814f-60f0bacf4270	\N	organization	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ba83eb89-1707-4acd-a6c1-a7657ac811da	2	20	f	\N	\N
af3a8aa8-32ac-4ec6-a32e-44e80b046524	\N	direct-grant-validate-username	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ff4b4009-e0ce-4ee6-8202-d579820d66dc	0	10	f	\N	\N
d28897fe-5646-4298-8194-b626ce66e051	\N	direct-grant-validate-password	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ff4b4009-e0ce-4ee6-8202-d579820d66dc	0	20	f	\N	\N
77018387-f784-4666-be3c-73c43fc9dec2	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ff4b4009-e0ce-4ee6-8202-d579820d66dc	1	30	t	0dd323c1-a9a8-4d1b-9b82-d34f5f080936	\N
10b093f4-b3c4-40eb-ab0e-e984dbf29711	\N	conditional-user-configured	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0dd323c1-a9a8-4d1b-9b82-d34f5f080936	0	10	f	\N	\N
985da009-a7af-4b6a-8f91-4bad5d5759df	\N	direct-grant-validate-otp	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0dd323c1-a9a8-4d1b-9b82-d34f5f080936	0	20	f	\N	\N
0c35073d-986a-44a8-9e30-5b795cd78c66	\N	registration-page-form	64ff6a29-5a1a-4538-bfe4-ab59163e838a	99aa369c-2732-41ec-8035-79eebd58de94	0	10	t	53458ee0-5375-4f1b-8e61-130056171d99	\N
14155566-5f1f-4456-82f7-e032375e9de8	\N	registration-user-creation	64ff6a29-5a1a-4538-bfe4-ab59163e838a	53458ee0-5375-4f1b-8e61-130056171d99	0	20	f	\N	\N
e4098aa4-fc34-47bd-ad23-9c6f9e9329d5	\N	registration-password-action	64ff6a29-5a1a-4538-bfe4-ab59163e838a	53458ee0-5375-4f1b-8e61-130056171d99	0	50	f	\N	\N
fbb90f2c-3d4a-4b6e-9704-2792f3f86db0	\N	registration-recaptcha-action	64ff6a29-5a1a-4538-bfe4-ab59163e838a	53458ee0-5375-4f1b-8e61-130056171d99	3	60	f	\N	\N
0640ebd7-f5f5-4805-a935-e7871a6f7e93	\N	registration-terms-and-conditions	64ff6a29-5a1a-4538-bfe4-ab59163e838a	53458ee0-5375-4f1b-8e61-130056171d99	3	70	f	\N	\N
7defd9ff-e3a9-4b3b-aa74-9347391792d2	\N	reset-credentials-choose-user	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0a2f28e3-5a07-4548-8e59-f10f73408903	0	10	f	\N	\N
5816bf0a-8cca-4f74-a65f-3bf569c9eb08	\N	reset-credential-email	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0a2f28e3-5a07-4548-8e59-f10f73408903	0	20	f	\N	\N
0d9de385-3644-4521-accc-b2cd01dd8c60	\N	reset-password	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0a2f28e3-5a07-4548-8e59-f10f73408903	0	30	f	\N	\N
58d50744-eefe-474a-b891-2f301cf5659b	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0a2f28e3-5a07-4548-8e59-f10f73408903	1	40	t	b30d4777-4f1e-49a2-9fd3-01c35d9a8bef	\N
074a76de-d562-4350-a135-302ea09e1c41	\N	conditional-user-configured	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b30d4777-4f1e-49a2-9fd3-01c35d9a8bef	0	10	f	\N	\N
e36d9f6c-e8bc-4c1c-a94b-97669c33f2ce	\N	reset-otp	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b30d4777-4f1e-49a2-9fd3-01c35d9a8bef	0	20	f	\N	\N
595e7019-5743-4948-98fc-c923d7dc0e9d	\N	client-secret	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1c24cfe9-6ca2-4607-a845-67f091bc46e7	2	10	f	\N	\N
58d7037c-d8d4-4a70-b9b6-1ae2a6042d7c	\N	client-jwt	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1c24cfe9-6ca2-4607-a845-67f091bc46e7	2	20	f	\N	\N
e74aba13-c100-4b43-b12e-3d0e922420f1	\N	client-secret-jwt	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1c24cfe9-6ca2-4607-a845-67f091bc46e7	2	30	f	\N	\N
4ccef6fe-d227-4626-9ad4-c9cdb32bdc92	\N	client-x509	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1c24cfe9-6ca2-4607-a845-67f091bc46e7	2	40	f	\N	\N
add2b5d9-8f2d-4612-b595-dee8010c2277	\N	idp-review-profile	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ec6a7655-27fb-4df5-a478-13236f3ff4bc	0	10	f	\N	43e25769-f193-4d43-87f4-9e738227b5c8
8467dcf9-3beb-4a46-b721-3d7128967737	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ec6a7655-27fb-4df5-a478-13236f3ff4bc	0	20	t	ab28d086-6218-462c-a648-471c07c0122b	\N
a12ddf85-5771-4712-ab3b-e31201da49a5	\N	idp-create-user-if-unique	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ab28d086-6218-462c-a648-471c07c0122b	2	10	f	\N	7cce090b-a263-4e9c-8cba-d45ebdefd69a
e4d3f8bd-e1b7-4188-b507-523ff3bada96	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ab28d086-6218-462c-a648-471c07c0122b	2	20	t	1820a7a5-0760-4a2e-b040-61fe986f63a6	\N
642fbf28-3180-4587-93d2-43d42ac822e4	\N	idp-confirm-link	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1820a7a5-0760-4a2e-b040-61fe986f63a6	0	10	f	\N	\N
f65a1d88-41db-4823-8fc8-55059a80aa6c	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1820a7a5-0760-4a2e-b040-61fe986f63a6	0	20	t	56a4e211-f755-47a1-b9d6-c1f6f40f5345	\N
5043ce5f-5e31-4f7f-b455-47dc4774bdae	\N	idp-email-verification	64ff6a29-5a1a-4538-bfe4-ab59163e838a	56a4e211-f755-47a1-b9d6-c1f6f40f5345	2	10	f	\N	\N
e8fe736f-f8eb-49e0-b73e-570a8c8c4670	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	56a4e211-f755-47a1-b9d6-c1f6f40f5345	2	20	t	f65dc609-1794-482a-ade0-aaaa785af1fb	\N
ff249892-b3e5-400a-bfdf-5fd58b5d87a7	\N	idp-username-password-form	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f65dc609-1794-482a-ade0-aaaa785af1fb	0	10	f	\N	\N
7210b368-1082-46be-9c10-2204fb3f6621	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f65dc609-1794-482a-ade0-aaaa785af1fb	1	20	t	a8a12a96-4689-4d14-b0b8-17695aa8dd4d	\N
9c9fab83-b3e7-489a-a6b4-e5d6f16871d5	\N	conditional-user-configured	64ff6a29-5a1a-4538-bfe4-ab59163e838a	a8a12a96-4689-4d14-b0b8-17695aa8dd4d	0	10	f	\N	\N
3172193a-f47d-4114-8864-8cde40c649ed	\N	auth-otp-form	64ff6a29-5a1a-4538-bfe4-ab59163e838a	a8a12a96-4689-4d14-b0b8-17695aa8dd4d	0	20	f	\N	\N
c1ce74a9-7cf9-4bf5-8e00-7282cf9b43c1	\N	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ec6a7655-27fb-4df5-a478-13236f3ff4bc	1	50	t	a61a29fa-2ac2-42c8-9633-b8fd2474540b	\N
e334cf37-b4fe-453d-8cac-6eecf99ab9b0	\N	conditional-user-configured	64ff6a29-5a1a-4538-bfe4-ab59163e838a	a61a29fa-2ac2-42c8-9633-b8fd2474540b	0	10	f	\N	\N
0d799cce-7c02-4817-9bec-a7d1fcb83444	\N	idp-add-organization-member	64ff6a29-5a1a-4538-bfe4-ab59163e838a	a61a29fa-2ac2-42c8-9633-b8fd2474540b	0	20	f	\N	\N
64c1a2d8-aad3-4c44-8b4f-48b869a1f92a	\N	http-basic-authenticator	64ff6a29-5a1a-4538-bfe4-ab59163e838a	869d6d73-458a-4bf2-82b1-e853ee9a3af4	0	10	f	\N	\N
667dba42-42e8-4f40-a11c-1361a68d63c4	\N	docker-http-basic-authenticator	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0c09a2bf-9fd8-46cc-8817-d9b5dcd1e17a	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
5114eaf6-20f1-488e-bddb-5d1705482083	browser	Browser based authentication	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	t	t
6253d3ee-4229-4e44-a78f-e0d3ef7b7277	forms	Username, password, otp and other auth forms.	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
223f5411-a278-4cb3-bc51-40f2ab17ad16	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
58f043c9-662d-4d91-939a-0a1f9573af25	direct grant	OpenID Connect Resource Owner Grant	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	t	t
e6fc7281-83a9-4b25-8838-2640d943dd5d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
eb3669ec-0dcd-4626-94cc-4f05eeb78b88	registration	Registration flow	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	t	t
4f418771-ca78-46a7-a1fe-c1be6738cb19	registration form	Registration form	5000cf22-fc94-4d79-8942-f7e575263547	form-flow	f	t
2453e655-9434-40ad-9cda-8cd6e566f858	reset credentials	Reset credentials for a user if they forgot their password or something	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	t	t
54193694-da3d-4dac-a7a1-255470569b8a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
edb809e4-e720-437f-be71-4153caa3306e	clients	Base authentication for clients	5000cf22-fc94-4d79-8942-f7e575263547	client-flow	t	t
36e8b7cb-3d27-43c3-9405-26ee99b59a01	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	t	t
e9b308f7-7f9b-4937-849c-efacca50aa0c	User creation or linking	Flow for the existing/non-existing user alternatives	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
b8c50f97-39a8-489c-937b-2da59548c7c7	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
f7752795-8aac-410a-afce-3a0264b90296	Account verification options	Method with which to verity the existing account	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
a866c5f7-d6b9-47c7-87e0-a9016d1a8366	Verify Existing Account by Re-authentication	Reauthentication of existing account	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
116ce65f-4249-4540-a61f-b392f957551e	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	f	t
cbdd79a0-85cc-4f3a-9278-f2a1c502568b	saml ecp	SAML ECP Profile Authentication Flow	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	t	t
bf7cbaf8-a205-4991-9be8-dbae7e397b03	docker auth	Used by Docker clients to authenticate against the IDP	5000cf22-fc94-4d79-8942-f7e575263547	basic-flow	t	t
8591a9b7-ffca-4e63-9517-8155111430e2	browser	Browser based authentication	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	t	t
f18843b7-f97f-4e38-ab71-75b055de2d84	forms	Username, password, otp and other auth forms.	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
73db2223-001d-49fb-ad62-29c6a56c5d05	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
75e9d796-a82e-4cb4-a4b5-bd556b138a2f	Organization	\N	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
ba83eb89-1707-4acd-a6c1-a7657ac811da	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
ff4b4009-e0ce-4ee6-8202-d579820d66dc	direct grant	OpenID Connect Resource Owner Grant	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	t	t
0dd323c1-a9a8-4d1b-9b82-d34f5f080936	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
99aa369c-2732-41ec-8035-79eebd58de94	registration	Registration flow	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	t	t
53458ee0-5375-4f1b-8e61-130056171d99	registration form	Registration form	64ff6a29-5a1a-4538-bfe4-ab59163e838a	form-flow	f	t
0a2f28e3-5a07-4548-8e59-f10f73408903	reset credentials	Reset credentials for a user if they forgot their password or something	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	t	t
b30d4777-4f1e-49a2-9fd3-01c35d9a8bef	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
1c24cfe9-6ca2-4607-a845-67f091bc46e7	clients	Base authentication for clients	64ff6a29-5a1a-4538-bfe4-ab59163e838a	client-flow	t	t
ec6a7655-27fb-4df5-a478-13236f3ff4bc	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	t	t
ab28d086-6218-462c-a648-471c07c0122b	User creation or linking	Flow for the existing/non-existing user alternatives	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
1820a7a5-0760-4a2e-b040-61fe986f63a6	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
56a4e211-f755-47a1-b9d6-c1f6f40f5345	Account verification options	Method with which to verity the existing account	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
f65dc609-1794-482a-ade0-aaaa785af1fb	Verify Existing Account by Re-authentication	Reauthentication of existing account	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
a8a12a96-4689-4d14-b0b8-17695aa8dd4d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
a61a29fa-2ac2-42c8-9633-b8fd2474540b	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	f	t
869d6d73-458a-4bf2-82b1-e853ee9a3af4	saml ecp	SAML ECP Profile Authentication Flow	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	t	t
0c09a2bf-9fd8-46cc-8817-d9b5dcd1e17a	docker auth	Used by Docker clients to authenticate against the IDP	64ff6a29-5a1a-4538-bfe4-ab59163e838a	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
c714c680-d725-461a-8362-2b80933d81bf	review profile config	5000cf22-fc94-4d79-8942-f7e575263547
c63b8a45-3792-4464-abc5-81634cddc722	create unique user config	5000cf22-fc94-4d79-8942-f7e575263547
43e25769-f193-4d43-87f4-9e738227b5c8	review profile config	64ff6a29-5a1a-4538-bfe4-ab59163e838a
7cce090b-a263-4e9c-8cba-d45ebdefd69a	create unique user config	64ff6a29-5a1a-4538-bfe4-ab59163e838a
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
c63b8a45-3792-4464-abc5-81634cddc722	false	require.password.update.after.registration
c714c680-d725-461a-8362-2b80933d81bf	missing	update.profile.on.first.login
43e25769-f193-4d43-87f4-9e738227b5c8	missing	update.profile.on.first.login
7cce090b-a263-4e9c-8cba-d45ebdefd69a	false	require.password.update.after.registration
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
4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	f	master-realm	0	f	\N	\N	t	\N	f	5000cf22-fc94-4d79-8942-f7e575263547	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	5000cf22-fc94-4d79-8942-f7e575263547	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f205166f-d4fb-481e-a5c1-4ee8cffb2906	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	5000cf22-fc94-4d79-8942-f7e575263547	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
bc538955-b97c-4c03-a371-48e6eac20493	t	f	broker	0	f	\N	\N	t	\N	f	5000cf22-fc94-4d79-8942-f7e575263547	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7804a2f3-c8ff-4afc-9a61-49837f83353d	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	5000cf22-fc94-4d79-8942-f7e575263547	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
06d53174-a077-4bb8-8c0d-527ba38375d2	t	t	admin-cli	0	t	\N	\N	f	\N	f	5000cf22-fc94-4d79-8942-f7e575263547	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	f	ahmed-realm	0	f	\N	\N	t	\N	f	5000cf22-fc94-4d79-8942-f7e575263547	\N	0	f	f	ahmed Realm	f	client-secret	\N	\N	\N	t	f	f	f
b547a77a-5e91-48a1-8288-0c44881a9054	t	f	realm-management	0	f	\N	\N	t	\N	f	64ff6a29-5a1a-4538-bfe4-ab59163e838a	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
cdd47509-7308-47bf-83cc-bebf9cb8a613	t	f	account	0	t	\N	/realms/ahmed/account/	f	\N	f	64ff6a29-5a1a-4538-bfe4-ab59163e838a	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7863fa10-ba9a-4cdd-aa72-70397455b30e	t	f	account-console	0	t	\N	/realms/ahmed/account/	f	\N	f	64ff6a29-5a1a-4538-bfe4-ab59163e838a	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ad124807-36c5-434e-8fc3-089d4c67ba45	t	f	broker	0	f	\N	\N	t	\N	f	64ff6a29-5a1a-4538-bfe4-ab59163e838a	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
92b2e86f-9e39-4e89-9c09-b56a0766785a	t	t	security-admin-console	0	t	\N	/admin/ahmed/console/	f	\N	f	64ff6a29-5a1a-4538-bfe4-ab59163e838a	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
96d26fa8-82b0-42e4-826a-6f91e4cf951d	t	t	admin-cli	0	t	\N	\N	f	\N	f	64ff6a29-5a1a-4538-bfe4-ab59163e838a	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
599987ac-15a6-4633-ad5a-2e8f7cd44d26	post.logout.redirect.uris	+
f205166f-d4fb-481e-a5c1-4ee8cffb2906	post.logout.redirect.uris	+
f205166f-d4fb-481e-a5c1-4ee8cffb2906	pkce.code.challenge.method	S256
7804a2f3-c8ff-4afc-9a61-49837f83353d	post.logout.redirect.uris	+
7804a2f3-c8ff-4afc-9a61-49837f83353d	pkce.code.challenge.method	S256
7804a2f3-c8ff-4afc-9a61-49837f83353d	client.use.lightweight.access.token.enabled	true
06d53174-a077-4bb8-8c0d-527ba38375d2	client.use.lightweight.access.token.enabled	true
cdd47509-7308-47bf-83cc-bebf9cb8a613	post.logout.redirect.uris	+
7863fa10-ba9a-4cdd-aa72-70397455b30e	post.logout.redirect.uris	+
7863fa10-ba9a-4cdd-aa72-70397455b30e	pkce.code.challenge.method	S256
92b2e86f-9e39-4e89-9c09-b56a0766785a	post.logout.redirect.uris	+
92b2e86f-9e39-4e89-9c09-b56a0766785a	pkce.code.challenge.method	S256
92b2e86f-9e39-4e89-9c09-b56a0766785a	client.use.lightweight.access.token.enabled	true
96d26fa8-82b0-42e4-826a-6f91e4cf951d	client.use.lightweight.access.token.enabled	true
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
dd263562-f229-4aa7-aabe-2408a5492950	offline_access	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect built-in scope: offline_access	openid-connect
4c7470e9-452c-4694-b7c5-23247d27d610	role_list	5000cf22-fc94-4d79-8942-f7e575263547	SAML role list	saml
d4d5ac14-28f1-41bc-808a-28156da6fc7a	saml_organization	5000cf22-fc94-4d79-8942-f7e575263547	Organization Membership	saml
af191aa0-1251-4d98-be15-5f2afaf1d788	profile	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect built-in scope: profile	openid-connect
1fefb907-66ad-46a8-9cad-bb2e529b53a9	email	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect built-in scope: email	openid-connect
c75b41ce-1b63-4b30-b163-636432ffaa0c	address	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect built-in scope: address	openid-connect
aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	phone	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect built-in scope: phone	openid-connect
4c7ce9bf-6af3-4769-9b1e-7065526bef8a	roles	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect scope for add user roles to the access token	openid-connect
5cb25839-3782-4365-b63c-9045efba34fe	web-origins	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect scope for add allowed web origins to the access token	openid-connect
7e7ab024-9d58-4a5f-9602-2c836a8dce4e	microprofile-jwt	5000cf22-fc94-4d79-8942-f7e575263547	Microprofile - JWT built-in scope	openid-connect
32016b06-96c7-4a34-9c8f-d48edaf6c221	acr	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
1755f152-fdac-4ab5-aaa0-d58034fd4151	basic	5000cf22-fc94-4d79-8942-f7e575263547	OpenID Connect scope for add all basic claims to the token	openid-connect
e3998e0c-368e-4541-8e9b-1eb54fd3434f	service_account	5000cf22-fc94-4d79-8942-f7e575263547	Specific scope for a client enabled for service accounts	openid-connect
23cd1bc8-c9e8-4add-ad4e-71dae75661c1	organization	5000cf22-fc94-4d79-8942-f7e575263547	Additional claims about the organization a subject belongs to	openid-connect
5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	offline_access	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect built-in scope: offline_access	openid-connect
1ae48abb-2969-4ad4-a910-f65ac6634a0d	role_list	64ff6a29-5a1a-4538-bfe4-ab59163e838a	SAML role list	saml
413732d1-e97f-4fb0-9582-b3a6aba198d2	saml_organization	64ff6a29-5a1a-4538-bfe4-ab59163e838a	Organization Membership	saml
32273d52-cd80-4329-9b89-1408cb99151c	profile	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect built-in scope: profile	openid-connect
56d755bf-b702-43b4-ab26-f4076ba472b4	email	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect built-in scope: email	openid-connect
d0f81eaa-0793-493f-bb94-634232d5a6f1	address	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect built-in scope: address	openid-connect
730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	phone	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect built-in scope: phone	openid-connect
a137ea02-90aa-4aa2-b06f-10cb5c969ade	roles	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect scope for add user roles to the access token	openid-connect
b2079f16-618e-40a0-abe8-91d2b3284528	web-origins	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect scope for add allowed web origins to the access token	openid-connect
0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	microprofile-jwt	64ff6a29-5a1a-4538-bfe4-ab59163e838a	Microprofile - JWT built-in scope	openid-connect
41cf9bde-5780-49ea-93d3-b0eca6cf1afe	acr	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
067e9ca0-7139-4220-8f64-846a3b20e5a4	basic	64ff6a29-5a1a-4538-bfe4-ab59163e838a	OpenID Connect scope for add all basic claims to the token	openid-connect
d3481c04-5c09-4b17-a2dc-b74a6d967a3a	service_account	64ff6a29-5a1a-4538-bfe4-ab59163e838a	Specific scope for a client enabled for service accounts	openid-connect
f34952aa-3de7-4199-b0b7-f85ee917768f	organization	64ff6a29-5a1a-4538-bfe4-ab59163e838a	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
dd263562-f229-4aa7-aabe-2408a5492950	true	display.on.consent.screen
dd263562-f229-4aa7-aabe-2408a5492950	${offlineAccessScopeConsentText}	consent.screen.text
4c7470e9-452c-4694-b7c5-23247d27d610	true	display.on.consent.screen
4c7470e9-452c-4694-b7c5-23247d27d610	${samlRoleListScopeConsentText}	consent.screen.text
d4d5ac14-28f1-41bc-808a-28156da6fc7a	false	display.on.consent.screen
af191aa0-1251-4d98-be15-5f2afaf1d788	true	display.on.consent.screen
af191aa0-1251-4d98-be15-5f2afaf1d788	${profileScopeConsentText}	consent.screen.text
af191aa0-1251-4d98-be15-5f2afaf1d788	true	include.in.token.scope
1fefb907-66ad-46a8-9cad-bb2e529b53a9	true	display.on.consent.screen
1fefb907-66ad-46a8-9cad-bb2e529b53a9	${emailScopeConsentText}	consent.screen.text
1fefb907-66ad-46a8-9cad-bb2e529b53a9	true	include.in.token.scope
c75b41ce-1b63-4b30-b163-636432ffaa0c	true	display.on.consent.screen
c75b41ce-1b63-4b30-b163-636432ffaa0c	${addressScopeConsentText}	consent.screen.text
c75b41ce-1b63-4b30-b163-636432ffaa0c	true	include.in.token.scope
aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	true	display.on.consent.screen
aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	${phoneScopeConsentText}	consent.screen.text
aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	true	include.in.token.scope
4c7ce9bf-6af3-4769-9b1e-7065526bef8a	true	display.on.consent.screen
4c7ce9bf-6af3-4769-9b1e-7065526bef8a	${rolesScopeConsentText}	consent.screen.text
4c7ce9bf-6af3-4769-9b1e-7065526bef8a	false	include.in.token.scope
5cb25839-3782-4365-b63c-9045efba34fe	false	display.on.consent.screen
5cb25839-3782-4365-b63c-9045efba34fe		consent.screen.text
5cb25839-3782-4365-b63c-9045efba34fe	false	include.in.token.scope
7e7ab024-9d58-4a5f-9602-2c836a8dce4e	false	display.on.consent.screen
7e7ab024-9d58-4a5f-9602-2c836a8dce4e	true	include.in.token.scope
32016b06-96c7-4a34-9c8f-d48edaf6c221	false	display.on.consent.screen
32016b06-96c7-4a34-9c8f-d48edaf6c221	false	include.in.token.scope
1755f152-fdac-4ab5-aaa0-d58034fd4151	false	display.on.consent.screen
1755f152-fdac-4ab5-aaa0-d58034fd4151	false	include.in.token.scope
e3998e0c-368e-4541-8e9b-1eb54fd3434f	false	display.on.consent.screen
e3998e0c-368e-4541-8e9b-1eb54fd3434f	false	include.in.token.scope
23cd1bc8-c9e8-4add-ad4e-71dae75661c1	true	display.on.consent.screen
23cd1bc8-c9e8-4add-ad4e-71dae75661c1	${organizationScopeConsentText}	consent.screen.text
23cd1bc8-c9e8-4add-ad4e-71dae75661c1	true	include.in.token.scope
5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	true	display.on.consent.screen
5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	${offlineAccessScopeConsentText}	consent.screen.text
1ae48abb-2969-4ad4-a910-f65ac6634a0d	true	display.on.consent.screen
1ae48abb-2969-4ad4-a910-f65ac6634a0d	${samlRoleListScopeConsentText}	consent.screen.text
413732d1-e97f-4fb0-9582-b3a6aba198d2	false	display.on.consent.screen
32273d52-cd80-4329-9b89-1408cb99151c	true	display.on.consent.screen
32273d52-cd80-4329-9b89-1408cb99151c	${profileScopeConsentText}	consent.screen.text
32273d52-cd80-4329-9b89-1408cb99151c	true	include.in.token.scope
56d755bf-b702-43b4-ab26-f4076ba472b4	true	display.on.consent.screen
56d755bf-b702-43b4-ab26-f4076ba472b4	${emailScopeConsentText}	consent.screen.text
56d755bf-b702-43b4-ab26-f4076ba472b4	true	include.in.token.scope
d0f81eaa-0793-493f-bb94-634232d5a6f1	true	display.on.consent.screen
d0f81eaa-0793-493f-bb94-634232d5a6f1	${addressScopeConsentText}	consent.screen.text
d0f81eaa-0793-493f-bb94-634232d5a6f1	true	include.in.token.scope
730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	true	display.on.consent.screen
730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	${phoneScopeConsentText}	consent.screen.text
730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	true	include.in.token.scope
a137ea02-90aa-4aa2-b06f-10cb5c969ade	true	display.on.consent.screen
a137ea02-90aa-4aa2-b06f-10cb5c969ade	${rolesScopeConsentText}	consent.screen.text
a137ea02-90aa-4aa2-b06f-10cb5c969ade	false	include.in.token.scope
b2079f16-618e-40a0-abe8-91d2b3284528	false	display.on.consent.screen
b2079f16-618e-40a0-abe8-91d2b3284528		consent.screen.text
b2079f16-618e-40a0-abe8-91d2b3284528	false	include.in.token.scope
0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	false	display.on.consent.screen
0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	true	include.in.token.scope
41cf9bde-5780-49ea-93d3-b0eca6cf1afe	false	display.on.consent.screen
41cf9bde-5780-49ea-93d3-b0eca6cf1afe	false	include.in.token.scope
067e9ca0-7139-4220-8f64-846a3b20e5a4	false	display.on.consent.screen
067e9ca0-7139-4220-8f64-846a3b20e5a4	false	include.in.token.scope
d3481c04-5c09-4b17-a2dc-b74a6d967a3a	false	display.on.consent.screen
d3481c04-5c09-4b17-a2dc-b74a6d967a3a	false	include.in.token.scope
f34952aa-3de7-4199-b0b7-f85ee917768f	true	display.on.consent.screen
f34952aa-3de7-4199-b0b7-f85ee917768f	${organizationScopeConsentText}	consent.screen.text
f34952aa-3de7-4199-b0b7-f85ee917768f	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
599987ac-15a6-4633-ad5a-2e8f7cd44d26	1fefb907-66ad-46a8-9cad-bb2e529b53a9	t
599987ac-15a6-4633-ad5a-2e8f7cd44d26	5cb25839-3782-4365-b63c-9045efba34fe	t
599987ac-15a6-4633-ad5a-2e8f7cd44d26	af191aa0-1251-4d98-be15-5f2afaf1d788	t
599987ac-15a6-4633-ad5a-2e8f7cd44d26	32016b06-96c7-4a34-9c8f-d48edaf6c221	t
599987ac-15a6-4633-ad5a-2e8f7cd44d26	1755f152-fdac-4ab5-aaa0-d58034fd4151	t
599987ac-15a6-4633-ad5a-2e8f7cd44d26	4c7ce9bf-6af3-4769-9b1e-7065526bef8a	t
599987ac-15a6-4633-ad5a-2e8f7cd44d26	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	f
599987ac-15a6-4633-ad5a-2e8f7cd44d26	dd263562-f229-4aa7-aabe-2408a5492950	f
599987ac-15a6-4633-ad5a-2e8f7cd44d26	c75b41ce-1b63-4b30-b163-636432ffaa0c	f
599987ac-15a6-4633-ad5a-2e8f7cd44d26	7e7ab024-9d58-4a5f-9602-2c836a8dce4e	f
599987ac-15a6-4633-ad5a-2e8f7cd44d26	23cd1bc8-c9e8-4add-ad4e-71dae75661c1	f
f205166f-d4fb-481e-a5c1-4ee8cffb2906	1fefb907-66ad-46a8-9cad-bb2e529b53a9	t
f205166f-d4fb-481e-a5c1-4ee8cffb2906	5cb25839-3782-4365-b63c-9045efba34fe	t
f205166f-d4fb-481e-a5c1-4ee8cffb2906	af191aa0-1251-4d98-be15-5f2afaf1d788	t
f205166f-d4fb-481e-a5c1-4ee8cffb2906	32016b06-96c7-4a34-9c8f-d48edaf6c221	t
f205166f-d4fb-481e-a5c1-4ee8cffb2906	1755f152-fdac-4ab5-aaa0-d58034fd4151	t
f205166f-d4fb-481e-a5c1-4ee8cffb2906	4c7ce9bf-6af3-4769-9b1e-7065526bef8a	t
f205166f-d4fb-481e-a5c1-4ee8cffb2906	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	f
f205166f-d4fb-481e-a5c1-4ee8cffb2906	dd263562-f229-4aa7-aabe-2408a5492950	f
f205166f-d4fb-481e-a5c1-4ee8cffb2906	c75b41ce-1b63-4b30-b163-636432ffaa0c	f
f205166f-d4fb-481e-a5c1-4ee8cffb2906	7e7ab024-9d58-4a5f-9602-2c836a8dce4e	f
f205166f-d4fb-481e-a5c1-4ee8cffb2906	23cd1bc8-c9e8-4add-ad4e-71dae75661c1	f
06d53174-a077-4bb8-8c0d-527ba38375d2	1fefb907-66ad-46a8-9cad-bb2e529b53a9	t
06d53174-a077-4bb8-8c0d-527ba38375d2	5cb25839-3782-4365-b63c-9045efba34fe	t
06d53174-a077-4bb8-8c0d-527ba38375d2	af191aa0-1251-4d98-be15-5f2afaf1d788	t
06d53174-a077-4bb8-8c0d-527ba38375d2	32016b06-96c7-4a34-9c8f-d48edaf6c221	t
06d53174-a077-4bb8-8c0d-527ba38375d2	1755f152-fdac-4ab5-aaa0-d58034fd4151	t
06d53174-a077-4bb8-8c0d-527ba38375d2	4c7ce9bf-6af3-4769-9b1e-7065526bef8a	t
06d53174-a077-4bb8-8c0d-527ba38375d2	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	f
06d53174-a077-4bb8-8c0d-527ba38375d2	dd263562-f229-4aa7-aabe-2408a5492950	f
06d53174-a077-4bb8-8c0d-527ba38375d2	c75b41ce-1b63-4b30-b163-636432ffaa0c	f
06d53174-a077-4bb8-8c0d-527ba38375d2	7e7ab024-9d58-4a5f-9602-2c836a8dce4e	f
06d53174-a077-4bb8-8c0d-527ba38375d2	23cd1bc8-c9e8-4add-ad4e-71dae75661c1	f
bc538955-b97c-4c03-a371-48e6eac20493	1fefb907-66ad-46a8-9cad-bb2e529b53a9	t
bc538955-b97c-4c03-a371-48e6eac20493	5cb25839-3782-4365-b63c-9045efba34fe	t
bc538955-b97c-4c03-a371-48e6eac20493	af191aa0-1251-4d98-be15-5f2afaf1d788	t
bc538955-b97c-4c03-a371-48e6eac20493	32016b06-96c7-4a34-9c8f-d48edaf6c221	t
bc538955-b97c-4c03-a371-48e6eac20493	1755f152-fdac-4ab5-aaa0-d58034fd4151	t
bc538955-b97c-4c03-a371-48e6eac20493	4c7ce9bf-6af3-4769-9b1e-7065526bef8a	t
bc538955-b97c-4c03-a371-48e6eac20493	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	f
bc538955-b97c-4c03-a371-48e6eac20493	dd263562-f229-4aa7-aabe-2408a5492950	f
bc538955-b97c-4c03-a371-48e6eac20493	c75b41ce-1b63-4b30-b163-636432ffaa0c	f
bc538955-b97c-4c03-a371-48e6eac20493	7e7ab024-9d58-4a5f-9602-2c836a8dce4e	f
bc538955-b97c-4c03-a371-48e6eac20493	23cd1bc8-c9e8-4add-ad4e-71dae75661c1	f
4a84d94c-77b7-46a2-baff-eecd72ed7d76	1fefb907-66ad-46a8-9cad-bb2e529b53a9	t
4a84d94c-77b7-46a2-baff-eecd72ed7d76	5cb25839-3782-4365-b63c-9045efba34fe	t
4a84d94c-77b7-46a2-baff-eecd72ed7d76	af191aa0-1251-4d98-be15-5f2afaf1d788	t
4a84d94c-77b7-46a2-baff-eecd72ed7d76	32016b06-96c7-4a34-9c8f-d48edaf6c221	t
4a84d94c-77b7-46a2-baff-eecd72ed7d76	1755f152-fdac-4ab5-aaa0-d58034fd4151	t
4a84d94c-77b7-46a2-baff-eecd72ed7d76	4c7ce9bf-6af3-4769-9b1e-7065526bef8a	t
4a84d94c-77b7-46a2-baff-eecd72ed7d76	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	f
4a84d94c-77b7-46a2-baff-eecd72ed7d76	dd263562-f229-4aa7-aabe-2408a5492950	f
4a84d94c-77b7-46a2-baff-eecd72ed7d76	c75b41ce-1b63-4b30-b163-636432ffaa0c	f
4a84d94c-77b7-46a2-baff-eecd72ed7d76	7e7ab024-9d58-4a5f-9602-2c836a8dce4e	f
4a84d94c-77b7-46a2-baff-eecd72ed7d76	23cd1bc8-c9e8-4add-ad4e-71dae75661c1	f
7804a2f3-c8ff-4afc-9a61-49837f83353d	1fefb907-66ad-46a8-9cad-bb2e529b53a9	t
7804a2f3-c8ff-4afc-9a61-49837f83353d	5cb25839-3782-4365-b63c-9045efba34fe	t
7804a2f3-c8ff-4afc-9a61-49837f83353d	af191aa0-1251-4d98-be15-5f2afaf1d788	t
7804a2f3-c8ff-4afc-9a61-49837f83353d	32016b06-96c7-4a34-9c8f-d48edaf6c221	t
7804a2f3-c8ff-4afc-9a61-49837f83353d	1755f152-fdac-4ab5-aaa0-d58034fd4151	t
7804a2f3-c8ff-4afc-9a61-49837f83353d	4c7ce9bf-6af3-4769-9b1e-7065526bef8a	t
7804a2f3-c8ff-4afc-9a61-49837f83353d	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	f
7804a2f3-c8ff-4afc-9a61-49837f83353d	dd263562-f229-4aa7-aabe-2408a5492950	f
7804a2f3-c8ff-4afc-9a61-49837f83353d	c75b41ce-1b63-4b30-b163-636432ffaa0c	f
7804a2f3-c8ff-4afc-9a61-49837f83353d	7e7ab024-9d58-4a5f-9602-2c836a8dce4e	f
7804a2f3-c8ff-4afc-9a61-49837f83353d	23cd1bc8-c9e8-4add-ad4e-71dae75661c1	f
cdd47509-7308-47bf-83cc-bebf9cb8a613	b2079f16-618e-40a0-abe8-91d2b3284528	t
cdd47509-7308-47bf-83cc-bebf9cb8a613	41cf9bde-5780-49ea-93d3-b0eca6cf1afe	t
cdd47509-7308-47bf-83cc-bebf9cb8a613	067e9ca0-7139-4220-8f64-846a3b20e5a4	t
cdd47509-7308-47bf-83cc-bebf9cb8a613	a137ea02-90aa-4aa2-b06f-10cb5c969ade	t
cdd47509-7308-47bf-83cc-bebf9cb8a613	32273d52-cd80-4329-9b89-1408cb99151c	t
cdd47509-7308-47bf-83cc-bebf9cb8a613	56d755bf-b702-43b4-ab26-f4076ba472b4	t
cdd47509-7308-47bf-83cc-bebf9cb8a613	f34952aa-3de7-4199-b0b7-f85ee917768f	f
cdd47509-7308-47bf-83cc-bebf9cb8a613	d0f81eaa-0793-493f-bb94-634232d5a6f1	f
cdd47509-7308-47bf-83cc-bebf9cb8a613	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	f
cdd47509-7308-47bf-83cc-bebf9cb8a613	5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	f
cdd47509-7308-47bf-83cc-bebf9cb8a613	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	f
7863fa10-ba9a-4cdd-aa72-70397455b30e	b2079f16-618e-40a0-abe8-91d2b3284528	t
7863fa10-ba9a-4cdd-aa72-70397455b30e	41cf9bde-5780-49ea-93d3-b0eca6cf1afe	t
7863fa10-ba9a-4cdd-aa72-70397455b30e	067e9ca0-7139-4220-8f64-846a3b20e5a4	t
7863fa10-ba9a-4cdd-aa72-70397455b30e	a137ea02-90aa-4aa2-b06f-10cb5c969ade	t
7863fa10-ba9a-4cdd-aa72-70397455b30e	32273d52-cd80-4329-9b89-1408cb99151c	t
7863fa10-ba9a-4cdd-aa72-70397455b30e	56d755bf-b702-43b4-ab26-f4076ba472b4	t
7863fa10-ba9a-4cdd-aa72-70397455b30e	f34952aa-3de7-4199-b0b7-f85ee917768f	f
7863fa10-ba9a-4cdd-aa72-70397455b30e	d0f81eaa-0793-493f-bb94-634232d5a6f1	f
7863fa10-ba9a-4cdd-aa72-70397455b30e	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	f
7863fa10-ba9a-4cdd-aa72-70397455b30e	5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	f
7863fa10-ba9a-4cdd-aa72-70397455b30e	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	f
96d26fa8-82b0-42e4-826a-6f91e4cf951d	b2079f16-618e-40a0-abe8-91d2b3284528	t
96d26fa8-82b0-42e4-826a-6f91e4cf951d	41cf9bde-5780-49ea-93d3-b0eca6cf1afe	t
96d26fa8-82b0-42e4-826a-6f91e4cf951d	067e9ca0-7139-4220-8f64-846a3b20e5a4	t
96d26fa8-82b0-42e4-826a-6f91e4cf951d	a137ea02-90aa-4aa2-b06f-10cb5c969ade	t
96d26fa8-82b0-42e4-826a-6f91e4cf951d	32273d52-cd80-4329-9b89-1408cb99151c	t
96d26fa8-82b0-42e4-826a-6f91e4cf951d	56d755bf-b702-43b4-ab26-f4076ba472b4	t
96d26fa8-82b0-42e4-826a-6f91e4cf951d	f34952aa-3de7-4199-b0b7-f85ee917768f	f
96d26fa8-82b0-42e4-826a-6f91e4cf951d	d0f81eaa-0793-493f-bb94-634232d5a6f1	f
96d26fa8-82b0-42e4-826a-6f91e4cf951d	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	f
96d26fa8-82b0-42e4-826a-6f91e4cf951d	5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	f
96d26fa8-82b0-42e4-826a-6f91e4cf951d	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	f
ad124807-36c5-434e-8fc3-089d4c67ba45	b2079f16-618e-40a0-abe8-91d2b3284528	t
ad124807-36c5-434e-8fc3-089d4c67ba45	41cf9bde-5780-49ea-93d3-b0eca6cf1afe	t
ad124807-36c5-434e-8fc3-089d4c67ba45	067e9ca0-7139-4220-8f64-846a3b20e5a4	t
ad124807-36c5-434e-8fc3-089d4c67ba45	a137ea02-90aa-4aa2-b06f-10cb5c969ade	t
ad124807-36c5-434e-8fc3-089d4c67ba45	32273d52-cd80-4329-9b89-1408cb99151c	t
ad124807-36c5-434e-8fc3-089d4c67ba45	56d755bf-b702-43b4-ab26-f4076ba472b4	t
ad124807-36c5-434e-8fc3-089d4c67ba45	f34952aa-3de7-4199-b0b7-f85ee917768f	f
ad124807-36c5-434e-8fc3-089d4c67ba45	d0f81eaa-0793-493f-bb94-634232d5a6f1	f
ad124807-36c5-434e-8fc3-089d4c67ba45	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	f
ad124807-36c5-434e-8fc3-089d4c67ba45	5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	f
ad124807-36c5-434e-8fc3-089d4c67ba45	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	f
b547a77a-5e91-48a1-8288-0c44881a9054	b2079f16-618e-40a0-abe8-91d2b3284528	t
b547a77a-5e91-48a1-8288-0c44881a9054	41cf9bde-5780-49ea-93d3-b0eca6cf1afe	t
b547a77a-5e91-48a1-8288-0c44881a9054	067e9ca0-7139-4220-8f64-846a3b20e5a4	t
b547a77a-5e91-48a1-8288-0c44881a9054	a137ea02-90aa-4aa2-b06f-10cb5c969ade	t
b547a77a-5e91-48a1-8288-0c44881a9054	32273d52-cd80-4329-9b89-1408cb99151c	t
b547a77a-5e91-48a1-8288-0c44881a9054	56d755bf-b702-43b4-ab26-f4076ba472b4	t
b547a77a-5e91-48a1-8288-0c44881a9054	f34952aa-3de7-4199-b0b7-f85ee917768f	f
b547a77a-5e91-48a1-8288-0c44881a9054	d0f81eaa-0793-493f-bb94-634232d5a6f1	f
b547a77a-5e91-48a1-8288-0c44881a9054	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	f
b547a77a-5e91-48a1-8288-0c44881a9054	5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	f
b547a77a-5e91-48a1-8288-0c44881a9054	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	f
92b2e86f-9e39-4e89-9c09-b56a0766785a	b2079f16-618e-40a0-abe8-91d2b3284528	t
92b2e86f-9e39-4e89-9c09-b56a0766785a	41cf9bde-5780-49ea-93d3-b0eca6cf1afe	t
92b2e86f-9e39-4e89-9c09-b56a0766785a	067e9ca0-7139-4220-8f64-846a3b20e5a4	t
92b2e86f-9e39-4e89-9c09-b56a0766785a	a137ea02-90aa-4aa2-b06f-10cb5c969ade	t
92b2e86f-9e39-4e89-9c09-b56a0766785a	32273d52-cd80-4329-9b89-1408cb99151c	t
92b2e86f-9e39-4e89-9c09-b56a0766785a	56d755bf-b702-43b4-ab26-f4076ba472b4	t
92b2e86f-9e39-4e89-9c09-b56a0766785a	f34952aa-3de7-4199-b0b7-f85ee917768f	f
92b2e86f-9e39-4e89-9c09-b56a0766785a	d0f81eaa-0793-493f-bb94-634232d5a6f1	f
92b2e86f-9e39-4e89-9c09-b56a0766785a	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	f
92b2e86f-9e39-4e89-9c09-b56a0766785a	5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	f
92b2e86f-9e39-4e89-9c09-b56a0766785a	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
dd263562-f229-4aa7-aabe-2408a5492950	143d6a37-85fe-4734-9c57-394f7535efa1
5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	4acb8774-0b01-4d7f-afb2-e3db0e71c3d3
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
bf9e210e-87f6-4045-8a68-d2ba91b3c74b	Trusted Hosts	5000cf22-fc94-4d79-8942-f7e575263547	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	anonymous
4c69cb0b-47b5-4a34-9593-284c3ba92ce6	Consent Required	5000cf22-fc94-4d79-8942-f7e575263547	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	anonymous
d809b228-023d-4eca-bd4e-4071c92a8c85	Full Scope Disabled	5000cf22-fc94-4d79-8942-f7e575263547	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	anonymous
e68a8da3-e83c-4dab-af86-37a1a962bbd0	Max Clients Limit	5000cf22-fc94-4d79-8942-f7e575263547	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	anonymous
efa6e23a-9290-4ed5-9345-a71d186730cd	Allowed Protocol Mapper Types	5000cf22-fc94-4d79-8942-f7e575263547	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	anonymous
1dc25cd2-66bf-415c-a981-69830c6408b9	Allowed Client Scopes	5000cf22-fc94-4d79-8942-f7e575263547	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	anonymous
cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	Allowed Protocol Mapper Types	5000cf22-fc94-4d79-8942-f7e575263547	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	authenticated
feaa1f28-7d7d-451a-98bb-2531062a265f	Allowed Client Scopes	5000cf22-fc94-4d79-8942-f7e575263547	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5000cf22-fc94-4d79-8942-f7e575263547	authenticated
5e900efe-12ee-43af-8ab5-5c34bb35e7f1	rsa-generated	5000cf22-fc94-4d79-8942-f7e575263547	rsa-generated	org.keycloak.keys.KeyProvider	5000cf22-fc94-4d79-8942-f7e575263547	\N
7408b8a5-e817-4867-bc37-4d6d061d2145	rsa-enc-generated	5000cf22-fc94-4d79-8942-f7e575263547	rsa-enc-generated	org.keycloak.keys.KeyProvider	5000cf22-fc94-4d79-8942-f7e575263547	\N
ed3fbbfa-9b8f-45e2-9450-abeb54f4e263	hmac-generated-hs512	5000cf22-fc94-4d79-8942-f7e575263547	hmac-generated	org.keycloak.keys.KeyProvider	5000cf22-fc94-4d79-8942-f7e575263547	\N
8e9a55a4-ab68-443c-82d4-2b0819589e4f	aes-generated	5000cf22-fc94-4d79-8942-f7e575263547	aes-generated	org.keycloak.keys.KeyProvider	5000cf22-fc94-4d79-8942-f7e575263547	\N
49d3243d-54e1-4589-ab51-f7e2619ab74b	\N	5000cf22-fc94-4d79-8942-f7e575263547	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	5000cf22-fc94-4d79-8942-f7e575263547	\N
b2ecd838-4756-42ef-adaf-64b14ced40df	rsa-generated	64ff6a29-5a1a-4538-bfe4-ab59163e838a	rsa-generated	org.keycloak.keys.KeyProvider	64ff6a29-5a1a-4538-bfe4-ab59163e838a	\N
b302702d-d2eb-43de-8d25-5209aef79130	rsa-enc-generated	64ff6a29-5a1a-4538-bfe4-ab59163e838a	rsa-enc-generated	org.keycloak.keys.KeyProvider	64ff6a29-5a1a-4538-bfe4-ab59163e838a	\N
b199b9bc-f8f9-4a2c-a6e2-72f53c5435e8	hmac-generated-hs512	64ff6a29-5a1a-4538-bfe4-ab59163e838a	hmac-generated	org.keycloak.keys.KeyProvider	64ff6a29-5a1a-4538-bfe4-ab59163e838a	\N
42e79879-f697-460b-8226-046d70c6e61f	aes-generated	64ff6a29-5a1a-4538-bfe4-ab59163e838a	aes-generated	org.keycloak.keys.KeyProvider	64ff6a29-5a1a-4538-bfe4-ab59163e838a	\N
cb14d23e-bd56-4e1c-9cca-04dc48f558b0	Trusted Hosts	64ff6a29-5a1a-4538-bfe4-ab59163e838a	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	anonymous
12b5a9af-3efb-4e1e-b4d5-f318abdead4a	Consent Required	64ff6a29-5a1a-4538-bfe4-ab59163e838a	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	anonymous
19028cae-e252-4f6d-ae81-8cd67ad52e0b	Full Scope Disabled	64ff6a29-5a1a-4538-bfe4-ab59163e838a	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	anonymous
cdc01f93-bb1f-466d-8dd7-d02a26bee4b7	Max Clients Limit	64ff6a29-5a1a-4538-bfe4-ab59163e838a	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	anonymous
54fcc625-bf88-47bf-a458-41ff57c8987d	Allowed Protocol Mapper Types	64ff6a29-5a1a-4538-bfe4-ab59163e838a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	anonymous
2e68a6d5-0827-4c5f-81ca-095e27445305	Allowed Client Scopes	64ff6a29-5a1a-4538-bfe4-ab59163e838a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	anonymous
df6d755d-655a-42ea-bc46-fa897fd3749a	Allowed Protocol Mapper Types	64ff6a29-5a1a-4538-bfe4-ab59163e838a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	authenticated
eb7ac7b9-0443-4dda-920d-965d44d24eeb	Allowed Client Scopes	64ff6a29-5a1a-4538-bfe4-ab59163e838a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
9879351e-36e2-43f2-97cd-17fcd2776988	e68a8da3-e83c-4dab-af86-37a1a962bbd0	max-clients	200
57aa469a-2f0d-4cef-bc38-7847471b3fa8	1dc25cd2-66bf-415c-a981-69830c6408b9	allow-default-scopes	true
791218ee-3c4b-410e-87dd-affc5fc462e1	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	oidc-address-mapper
dc0d270e-1361-4ad0-91b1-e86b93c514f5	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	saml-role-list-mapper
4f12adf3-61dd-4633-9239-071c94848a01	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0174e8d1-f0eb-4061-8210-c425043effb3	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	saml-user-attribute-mapper
dcbe9690-7f99-421e-a1d1-e2e5414d7a68	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b9502423-4a61-4aa9-ac1f-909561f1cccc	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	oidc-full-name-mapper
9c29be02-1244-411f-8add-7be0c47d3e85	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	saml-user-property-mapper
51bd2a78-dbca-4521-8bcd-6baed6821e55	cb4e2552-6a20-4cd0-bb85-5c1b99dfc376	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
49fa26ec-7aa5-48f8-889b-1853ae8d44da	feaa1f28-7d7d-451a-98bb-2531062a265f	allow-default-scopes	true
f0afeccd-87d8-4ec9-a48a-fc5d08651459	bf9e210e-87f6-4045-8a68-d2ba91b3c74b	host-sending-registration-request-must-match	true
d3419304-a6cb-4365-a233-eef674d0cfb9	bf9e210e-87f6-4045-8a68-d2ba91b3c74b	client-uris-must-match	true
21636ea8-7dba-4afc-aa83-6f5d4120d5ca	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	saml-user-attribute-mapper
5dc3df32-4a35-4c5e-8357-38a8961e505d	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
faf48bfc-6db8-424d-8fc7-35504b4ac170	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	saml-user-property-mapper
1684233c-4b11-41ab-a5eb-76d344ce647b	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	oidc-address-mapper
6197265b-cf99-4f26-9571-2cd91838a0d6	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
638e1be2-7253-4bf5-881c-868573d5a05c	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
98094d1e-3a3d-45f8-911c-cf73ae8e61ac	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	oidc-full-name-mapper
1430c9f8-fbf5-493a-a708-29547581fc84	efa6e23a-9290-4ed5-9345-a71d186730cd	allowed-protocol-mapper-types	saml-role-list-mapper
eae6b126-4fdf-48dd-9886-49f6890b5c4f	7408b8a5-e817-4867-bc37-4d6d061d2145	privateKey	MIIEogIBAAKCAQEAz4YpYyse6M1AqwafCMgbOUz1qbYMZpccgCyfj0gbHVlM9OZo2F3PKHMDxj2ErwSAnz5EFvvOEQUtur056sY7j9Nvj4UA9otWeZYTHY4/apcGp//EduKVtytaqTtDzxO5H0xP3GIKMCBXAIhnjieh1vZYOosRUmSS+vfD4qNPqCw46PLN6BXrfVTTRfiPKHbOSq3kz5zPkgKXHfEuV8z7t8najwrpFxbAl/YnJVd9XcEaMd7EoL+26aUgf2gzKWkhWTnp6p36HU/7vtOBXa5Ryw2b0DWyKze6nsjlMsj2qALArsBYoAeWHwI7IyE81Ykk+R6qNpz0PceYZf9sKEL9uQIDAQABAoIBAAl1JQ44sR4teoDA2r8Y9YqpO/npystjICCkR/pM8DVodDYmCQmxTsdaZIXkmFcslpsLSKmefK/wYzrjNFBDjAPcQDWTe22BAKYmZYUfjjrSmrJN2PuNDIMuReG4CnlVvgZT4UDbM/kpBCYJUWTcYAcOr4stetLdNAidgY8i37a7hif2Qc0weUvR21aZAwndZxJFFQObUpa/8dn72ZgG9Lf64oZ2GkZ7/BkrGL2qS3mNPEKGgQMWFja3mlMA/jAfRIdo7+zugX/FJrHdvJVvk+PqbSUGNplHcYhZv29B4gQe1wt+EcsixSY6LTSoFhnjo9DhGDjZie0+L86R9we7U90CgYEA9duXZ3H+kJQOk/gRujzn64839d4Yp5dVjiJr+ixJ3nH61f40HNvOP6Hz/dIBbo2X3uM+1BwZa/e3BdEZ6rZJcmQMu1nqZk1lsR3OU4Z/0a9fIR9nx2XXyoF4AtLpd4ZIKpJKUjZH8uTr2O7xa/yYLqFg5SX6eoc4P4mu3xmm5j0CgYEA2BW+KR4bFbdw9gvEMUOL5Cc1dCUbfDTUHGx+Jbd0OOYaOsUytBiiIUAh7OtHY53k+nGYEn7FFJlc0aqoQ5jcur/S4IkqKm1a5gXuMO7NiEXTHa0RD9IT8vXtwWV7O60b1XH4Y8dRsAqCxaTZ+YUSrB1WF7It4jF2CVHCbpzL6S0CgYBlG9HAMRlHzBvSropb1QBr15JkAtqQ0aPVuEI/uEcIvEc0Cj7UP3Eqqif1kpAULxbuCvajtIqf5FfYhI3sANtjt9Gkmu3S9LGFjYR0xTN7wGuW65t6XV/JYEVCpApvpUG4gEEgXkJomcyEgn+2sULEqol2s4+3JDT1rGHGTn5c4QKBgD+E/LZXjDyxBPq+8LhOk9PIltUCh3bWjLeiSN7Lc9W6BmHaUBJS324IzTA45W5qHsJkHADr1QE+J+PWV8ovKEuZUeMBTyzTopHVknQ97pstc2bY1hgheA3Gr1JXg4dCVtlCvHKQR/oIzPJOiGjp7lg782/Zx9UjFwCcURx06RgtAoGAFludX4MDr9/Q3t3rZS+Ymx+DKn+/iU9zS6Dtuijo0W6WZl+B8+RvWRLDqT3IBf6Yci+EFwu5latIo3YGCfRYrQZ29bLJ5rg/E+oUNzDjD4Z6S411caOZ3WUjpS/W4s/VTp9KG9IiUlLyHZyY0tHyFvApiCYGs9EmqDxuWSqABFk=
4e49ac39-3031-4470-bec5-e7190f72f87a	7408b8a5-e817-4867-bc37-4d6d061d2145	algorithm	RSA-OAEP
54222f99-ee30-4a2d-aa2f-cea3244e78ed	7408b8a5-e817-4867-bc37-4d6d061d2145	keyUse	ENC
8931123a-fe3c-481e-abc7-ba64754b0b00	7408b8a5-e817-4867-bc37-4d6d061d2145	certificate	MIICmzCCAYMCBgGVdb5a9jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzA4MTIzMTA0WhcNMzUwMzA4MTIzMjQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDPhiljKx7ozUCrBp8IyBs5TPWptgxmlxyALJ+PSBsdWUz05mjYXc8ocwPGPYSvBICfPkQW+84RBS26vTnqxjuP02+PhQD2i1Z5lhMdjj9qlwan/8R24pW3K1qpO0PPE7kfTE/cYgowIFcAiGeOJ6HW9lg6ixFSZJL698Pio0+oLDjo8s3oFet9VNNF+I8ods5KreTPnM+SApcd8S5XzPu3ydqPCukXFsCX9iclV31dwRox3sSgv7bppSB/aDMpaSFZOenqnfodT/u+04FdrlHLDZvQNbIrN7qeyOUyyPaoAsCuwFigB5YfAjsjITzViST5Hqo2nPQ9x5hl/2woQv25AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIzsrZTaz7/BLJXHUp7ehLMhS2S2m+iKxGbdCE81rf7Fny3aTSVJ/xAjYo84zf4UeXZV+wW0YD94xX0KcGJjYdZgpjTZhbtWxptQQCPOJDPLX889+Pm5fZ8VVoCMfG3IPiF1q4mA52RGaGYWT9BpDeYWo8yFTWPPk9Idp4SyN6eZn/nLTaU0lhjgTnp3ghy7H8NAFHTfsni/ZaND+tkdsQwxBKeDJNnAmbOeskWUs118MLKJDZmoOUPByuwS7cpnyF+IgeHtpfIghbvzKACrCCpnQjgSyFnZDNz5pVXUqbXW6boB2y/sbqh4wHwirv/D4OauBrzw0Yku8rsOz31L/hY=
6d3c1b62-a2c0-41e0-aefb-2fda7eebb49c	7408b8a5-e817-4867-bc37-4d6d061d2145	priority	100
37b2f655-8042-4c05-9476-bcc91d531abe	ed3fbbfa-9b8f-45e2-9450-abeb54f4e263	secret	HzmJeUxwNo1ciFZLfWq_mXHJi9lj0AVkA-2_bL4WGyqgpsjlGlPFFlQulXAiPUtsF1jIFwURAE1Coip9FSJmT_oVnbR9kqQrx116pLGA9fduR8ibO1y36k17TI2NY9euGHGDp7r_FBWAMGVDCM-X_NJJ5V_VcKlG22BT7fer7GY
5d99d531-081f-486f-aa04-24fd898a9976	ed3fbbfa-9b8f-45e2-9450-abeb54f4e263	priority	100
ed283926-d668-4135-af1e-645b3d0e10b7	ed3fbbfa-9b8f-45e2-9450-abeb54f4e263	algorithm	HS512
10df55cd-d078-4979-ae7a-4d5f80cf550e	ed3fbbfa-9b8f-45e2-9450-abeb54f4e263	kid	e61982ed-4d0c-4dbf-aea7-7b56bab248b9
565fd6a2-bee5-4432-9384-4bce872a8eda	5e900efe-12ee-43af-8ab5-5c34bb35e7f1	priority	100
cb94cfd8-6cbd-4fd0-a38b-3d1e078aefe2	5e900efe-12ee-43af-8ab5-5c34bb35e7f1	certificate	MIICmzCCAYMCBgGVdb5Z/zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzA4MTIzMTA0WhcNMzUwMzA4MTIzMjQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDJzbLb9goX3dva0wyes79VpdWSzpwdgO/evsK2eFVQ7GE2Fvjj0IMHRca+04g6LM3fY2rti5GerxmqJmYkNQ9YO0rdsHR0RAplcUbqH9lYD9RJ8/F1vwFlKXqzgizm67A9o55NVgXg2K2eyr9gqiOzrdtxLrELA2aNXiwCxSbI5C3dXxoWwz8osBzTJffK9hAvnTA9//PNqCYtKoNbdFLcLKtFZZruj2yfBVsQwuACG2QRg2kswDn/94zy6ZJLMjmE1fx3CJxSMIgkzrXHY05YNOsr5UwbOOfO2XHB3Kp4/qqLH3TFc0rZrIEB+UFGeThJJUsIUx6YDUX7HZ03r5n3AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIVJlrbrxO6cs8R7kmfDhl57ncV0BbCtRaIOV+ijAv7TMcCIGfTVh2IIJS06RLcE3HmQNtcgcEZ40wo7oLRW65f9+yDByUXQSYN0slEBajJ4AXHrY34cYdhBASaPkaxIdRlRrzJFsPpqzgIVLJ/JGVHJiRw3wWTxAes1R7jSDZQoHynXGSDlIhmAG35EgM1lkVQ9g+lUmrF4WQE9XwOiSaYte9+TtgtvCZ3na8pGSaYmX+pvSvqZ5aneSn/33BaJ4BFNKdgbPHhu9iYY4qbhXwb0Mb+8DJlf6wyumUswMqZLeo4Tp7uwhT6pz5cpW0xOWo21pELDACedSNOwEUB9+e8=
0c0a4e50-d12f-4347-857e-c80e5ad24b4e	5e900efe-12ee-43af-8ab5-5c34bb35e7f1	privateKey	MIIEogIBAAKCAQEAyc2y2/YKF93b2tMMnrO/VaXVks6cHYDv3r7CtnhVUOxhNhb449CDB0XGvtOIOizN32Nq7YuRnq8ZqiZmJDUPWDtK3bB0dEQKZXFG6h/ZWA/USfPxdb8BZSl6s4Is5uuwPaOeTVYF4Nitnsq/YKojs63bcS6xCwNmjV4sAsUmyOQt3V8aFsM/KLAc0yX3yvYQL50wPf/zzagmLSqDW3RS3CyrRWWa7o9snwVbEMLgAhtkEYNpLMA5//eM8umSSzI5hNX8dwicUjCIJM61x2NOWDTrK+VMGzjnztlxwdyqeP6qix90xXNK2ayBAflBRnk4SSVLCFMemA1F+x2dN6+Z9wIDAQABAoIBAEBYv5xVkphTnMPkodSE2hCURUp/aNYbg+DRkMKgEgwwozqdDpWNqgoKnLnCN2DdYnPFfpXp9+/SQ2u2vMD0zkTC+zc/CZL9ExePjB4hM6tZuMYv66Ew22AHXuGYM3saUeMFpfdg45TzYkEMwwMunR2w5RTs33T0i6GuEnh7psdNManB9YzhBLmS/rlQ0bLkDu1GM1wNoVo/qygS2qkGDRZiYyzBOE9uoy1X5NryHIFEoQnLGlRZ8xjU84jBY83uzCY7XyQKfGPOMIGwc7Rloe8vRxY7i8PPlnGMjSi18YaOFa5WNLmSTia7tmv7YAXxB+PBVm3fGhLlc02gNAA/xuECgYEA6+omEYwZ9dGFaXeAKK4+iSp93QIvHd15D8m1SiK/RIjjAWfXwtDmsjgjDpmRwcP9mKBYBfgooTvlNsmcmXQBX09i2Nm6TF1ZYgGGSjMPFekmFUCddemnGHVva6PMWokLB0l7qedqjzZ4fSfzJ8yBa2irR1W2ZyxHIf3a2z5ry0cCgYEA2vwVpmRiMGdBVgRkfSWv8lGQdqviT/FrxZMf7RX0uIRetAHV3U1Ww7AkN27vdjvZMBNEZtN3X00bF1s13FE8Xe0tZGDOEXNSBK7ao1uqf0Gt5MKvzqe40AicCMXI8AWEeSVkMvNpNaPwnE0oN58Gd17c5hLCpRgbxQJ/cHcUs9ECgYBH7fZ5dywbJSz2QTdUL/xlOg1yK05OXs6gn7Gkzv9eWBZOwWipv6P3RuJ5ex1T5PwXYxwzhbxtnKOAluwmZZZdhwjucUQ6MGQmW6ykRvkchx/TbwYTg5AtBvFX8nNGT26LZD5OSX7V95e5IUskIVh8dUdz0pBw2LE/jfUCz/9x1QKBgBgCBRmd7cniuB4HE0FJLXYCjTUFeSVMkYUysRBcFN1Z3cwcW2cMwJNprz7IkcZDn3cO1bP0QSUYnfy8ijYiTdz6ULythEoTe4154gyA0ztqZvcqhP3CE5fzKbAohvQRlsl1WPvhBcrUs19fciZO7/WMV+l9awuQjhLWSER7ObDRAoGAED2e4fqflaID0mgfMqYZmsrC4mXEhSRKTcczgfsZRw6r8yPhG67uhnvqzFe1UAsXS/+qKukzVEj+cVO+A3bjeXNY+OLWsLadqEq2iQhlOA0op/UUZ8SHIP630jo4qnnEnd+aIdeJLaOLky3kEc/QGRqAzpcUlD8Y4JLdWZ6UfBM=
997d0c2a-0eea-4963-a3ca-3586cce03760	5e900efe-12ee-43af-8ab5-5c34bb35e7f1	keyUse	SIG
e7fd52cf-b208-4b8c-aa7e-3cf3d9101299	49d3243d-54e1-4589-ab51-f7e2619ab74b	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
19d3cf6b-7fa0-4a0a-8a86-55b922f5ce33	8e9a55a4-ab68-443c-82d4-2b0819589e4f	kid	7078793b-9b97-41c3-b9f9-d8cb83dcf29c
8a0fa604-bbd6-4e7f-8fe7-7b41261e90aa	8e9a55a4-ab68-443c-82d4-2b0819589e4f	secret	NbDtGpPg6N4HzdjcKX1RAg
c0564a3f-c523-4314-b507-a27ffa88017d	8e9a55a4-ab68-443c-82d4-2b0819589e4f	priority	100
d00e3465-401c-4fef-9092-56b5286f07c3	b2ecd838-4756-42ef-adaf-64b14ced40df	keyUse	SIG
d40782cf-7ab0-49be-b89d-1a0e692ad51a	b2ecd838-4756-42ef-adaf-64b14ced40df	certificate	MIICmTCCAYECBgGVf21avTANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVhaG1lZDAeFw0yNTAzMTAwOTM4NDdaFw0zNTAzMTAwOTQwMjdaMBAxDjAMBgNVBAMMBWFobWVkMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAygC6U6rKSQCgU0+B+Cue6V8aROsYWhqL46HcCJSWsGN8DZsuQXV9XNjwBvhO81boFx4aR/ZqUDMF6mHUmoQhG1V1Rv1hc7dZASYUhDUug0l76Rrjoo6C8sz6xUF6vBRBDx+/r7bTjnvFuHwKGfZGRomr/VUvDJbMzEbQ0OAul0BCg61E0cPft6DnOwKho6tTnznUHrUibAiIbdCCJELbeG7RZyYuflW/uSj0ctajYB+OHvr7IDwnup33tl7lek4vdLfWvRq8j0g38f64ttYxd3jOm3yfuD7hAtsVMKwCGQKbdXWVexsNBiq/vqkGSacanpSiNH+O8jD3UdaHX0Lw8wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCgY62fLx3nxRikq6jpKiUPIxPbNh56LfPVYhxjyMXOeEEhOnPwdX5lwiOqV1qfWevIx8Fnf39d61SzdFTUv4rWBeywcdAGO3f+CX2EssuPA4ac+BHVhw7qWlLFyMORWkU/bSuKvQi7QXWpEHSt9ltL14dqD3hIFaetDoe0SHz9bQ2Q5sQcgWy7lCrltsMt3c+OHtSDXRKDABhsCTzT6UPXyeC8+88i903bSTBMwgZRPlVBoUqHVLseNm4L3cEM5CJ/RVk4AQEeB8RgfvLJjo3GVin61szVPY+Orx4rJYSOcm98wqDzdWlTO9NdKW6PAuIZX4U0PO88y8VifWefd+7O
e8e32549-7e60-484a-adba-9bc42e9353bc	b2ecd838-4756-42ef-adaf-64b14ced40df	privateKey	MIIEpAIBAAKCAQEAygC6U6rKSQCgU0+B+Cue6V8aROsYWhqL46HcCJSWsGN8DZsuQXV9XNjwBvhO81boFx4aR/ZqUDMF6mHUmoQhG1V1Rv1hc7dZASYUhDUug0l76Rrjoo6C8sz6xUF6vBRBDx+/r7bTjnvFuHwKGfZGRomr/VUvDJbMzEbQ0OAul0BCg61E0cPft6DnOwKho6tTnznUHrUibAiIbdCCJELbeG7RZyYuflW/uSj0ctajYB+OHvr7IDwnup33tl7lek4vdLfWvRq8j0g38f64ttYxd3jOm3yfuD7hAtsVMKwCGQKbdXWVexsNBiq/vqkGSacanpSiNH+O8jD3UdaHX0Lw8wIDAQABAoIBAAjQAYQotWMVuwJxCG3P7VwnneKq0cJzwDphwDkpmyDxcVYgn0lHLsoDQ5/Ynlnt85Mdz5S0uQxsC9KFV3wxAa0kTC9lwQyGaUSF3Kt5EuEZLn9lZzZOYR0ZkmK5PN/OqTK+AyO1zKkj8jGRsiXrmtyoVE+cs0BDDFOb6HxsUB860227sYEfqBp79QF6DYrvh7dJiAPheFweQoUWuZRJh6qc7qBHpnTrgEIOZU2H5WcoF+3PrLQopfdtungnOnq35/yvulqdQoYa46TbuI3wrM5INPkfynFB8H8nx81JWFBRld0UJpn7gNAI+fKv647iMATHNh/eWXv4JO7YenlgqokCgYEA+EuWaHvB3/IHwJ5GFOoS16l41xCOYsTE0fwFhgoECtoG7pAGeOYnGbk93TPz5D5nSpqkdZ7hgebWz34rerGRxiDFHMTrAecJV5KaRziP/Jqp7nwv2nuIa/PwEs33GwV0G4lblw86IGdPT6T1WxbyrWI7NuOvx1sto3dFZnJqdPkCgYEA0EVm15tXUW1u3NRRHpWhYTaVps011RAoRAJ+CcGOdrWK7938EdcBnxUJInr5qBIfWdReCE8wm2p9acpUAZuZ0C6AcdMLaKks9t6Tgz5JisvwGSxrp8QB3KMWsKqlktd3ohNWCkzaYSSKFabV5TNtC9j8THr4ATA86yqD1JIPDEsCgYEApFnEMVzZs9aM8x7Q3L8jwcTXy+OVnCMK9MORFGxEyLoQpJCI+DW/4/MN1AGzin0T+fnqqkCEnGuj/KxTM1+eUjsWvjhKJnQ7ZtAPdt0l0dq+aLGjK0dhwbMyUgArdKNje2asTY0yuIgpo1pZXfYOpF3FPEvx6k+cIfus4GcTuGECgYEAlwO7rlpU1hYjbLwGlcapXXPWzzu87ODqUWX9PdW7FxhLxeGQBN+BrXfzR60jmVqKoPf7tsq00/xDM5Ihl4jb3rfZKq98dkc080wwadmgOaPmVFqBNQRK1VDsAu25YOAbPsoGeTGApy93cHuoXKkNSKntRwdjDHmNsncBYAEIKEECgYAW5OB1FKU8oQkbUhSPxfWUlQIV2839I0LYb9tqjE3p8yXgB90k0+YZEEZW0gVNQLrRrxnj7TbF//LKCHv2UvFu/19H0ENo1dkAmLSanx3AvULCoYCPIR25hc0vC2/V8OvhyxKsHIRT4MdlFB5N/QBmPBMDovw9rdz+j4IpU+ePLg==
8aa11f48-4b4a-41da-abbd-e5e4ce8d8669	b2ecd838-4756-42ef-adaf-64b14ced40df	priority	100
04010a98-f957-4a2a-b34d-076d54ba9e96	b199b9bc-f8f9-4a2c-a6e2-72f53c5435e8	algorithm	HS512
9f1c38cc-6e92-432a-a221-ec8e245440cf	b199b9bc-f8f9-4a2c-a6e2-72f53c5435e8	kid	26973a0d-f7f5-478b-b3b7-ef9171eb56d0
94f4f70a-ce53-4d76-add8-b3cfcb6c9d23	b199b9bc-f8f9-4a2c-a6e2-72f53c5435e8	secret	ZacWdIcl58kGrEVtM3htLhkj7EhtCQBn2yWpupWJH7aBXYZ-MvVoerRMi97qVNftkbe5yBkPDZtVeiRoCHCpl5yUXcxEIR2JtIuCo07_QeMMMggDsXDC1fgJIvdSNkgwltMv_DVv75sEPEbVFDRzzQDgEu6gbvWNpDFNV6hnP_Q
87aa1a92-bc5b-4342-a1ce-db32f7c19709	b199b9bc-f8f9-4a2c-a6e2-72f53c5435e8	priority	100
2aad81c8-83de-4368-b359-883debf61705	42e79879-f697-460b-8226-046d70c6e61f	priority	100
c805d369-2baa-485f-8de2-275e83a80bdf	42e79879-f697-460b-8226-046d70c6e61f	secret	pkzJR6cHwzoB2aoaEyPhHQ
11dd6639-398d-4595-9f30-9b02168932aa	42e79879-f697-460b-8226-046d70c6e61f	kid	10c76abd-475b-4458-b206-e6b193f5d0f8
2bf9c35b-ade8-427d-b78b-30bde8ab2e42	b302702d-d2eb-43de-8d25-5209aef79130	privateKey	MIIEogIBAAKCAQEAlhtyp59Uba5HvxRdX8bH8df3S12fpS+zPonDJaLhjB3hULy4DdNjK18NlTFURFXh+pIZdpuH0+rEK6z+hpT9p8AFIP1lbU2YrCvCrxBjuIQm7Vk1n0kCC2wf5KGvfG+mZK52BZL+mdzR4f+8mfKAW40ZNyORz4+b7LxgSP06SwtVbYiEFUIZ4MhwVqhrv5D8Pqj8ZWodJ7VffTJ6cVq4qJxwZGX6RFaHMrR4EeagtSH3/2CXcGrgYqhlTlXHX4raD3yUxXPBNpXZn1y6yT3HC7rtvwFHgYMTPM2XCVRHNhp7yceA8WBEM8coVSDnkK0hsQjOBUVnJC+iD2tfV+kk+QIDAQABAoIBADYNgT6CHeV3FiflHfCgxJw+YDMX7iaOJDYXZpnVavHJSrsHkiGMZtAV5O69+jG3WW4hESFIRWOWzPhLTcZJvYOcHlywUsdG43zQL0VaGga2M8xRTQFkSWOyllN+s5IUJG9p8V71fVALl9qRfClVjUoqZ5OW7+k1tfjMJsHxyf1+dH+1BhaaMiJYbnnzrGtvjq7wSoYEAejEWbrJ3GoxCArCXPITMb/kryXoGkXcY614EN5bc7n3EvJfuPkrcs88e0GC/ClN17A+r68/mbo4hxJ1b3ZpMoZjWwtLiU2NYBiv9R8qFSP58rl0OgrPylpoKM0ZaedJW9Ld56H3AUXtAAcCgYEAzKTzAcOLcz7VCZHSH5wZrjnXECgmnBXyNTtuUU67PPJJOuvsVc7csVLBja5m/nwlTL6eJ+yZMpJbccFe/WwC2MDCCl0s2bQwW6edW+fcygM+Rw9LxgcZFVgUeKDGsvVK1MRaZNVbsps4hV8kzrWD0IB0ue7ID4tf2eoQhanNTpcCgYEAu8bZH/pluX8NlZKP1nCgOfNdybJrGr7fU2EEeA/8u5zfOSHjLRF7j03fB6Jp1FRhU4+j8oBrpCH3L4+r3ppxBNlw3H0X+M4XzTuGtqJ7MBUf2DaQ0zQnpIMltV/tXNIgTTegiQ674E7MgaLo2JkBsvqWUCTWmIMwkgBICxNoKu8CgYAFs6rZp7sg8OU6qQdzvgOxKQdm+ddpjer7tLY0Kb9pyU5lB+HD2kmn3yhpbCyOdqMLalw5vIvgLtfBaaPd576Ej4pYg5QWVMDsLNVjlChAsKpxjGmOEPCP+a5IViJzJgZ5uybRnGg7p7uBa884uzH7Azk9XPvSAw4eojjnoH2J7QKBgB8sY99rMngZH6g1LKvtBqyYOnnBpQZLqcet05AbF1oOMQDLH2vb+ydPRjd+PxOA7qdwsUcRCs201dSPhXjvKtQjRRlVqyUjEdCAkVzAnLLezuqWJHTrs6kcHKZ/xmgiejpXgc8/IvGaI1liMkXDIQUVlN65PucS4H1cjplIH4MBAoGABnT7ub/f51x6fxhJYCnC+qcwuTTn9/o8M4fT7E4uYA8enAbaeW5UyCwVS04EWsf4bDEhFEEtBULvQ0gOZq1cmtzkwJtTisFztOWQQrKxPwhRdeBp5sqkFrf8Oza3pPvY75GBI5f7Cc1FqBgd1NJQPi98BsSXks2Fgd7CLN+qvAE=
9b177edf-d88d-44db-9be1-e6e960b7b560	b302702d-d2eb-43de-8d25-5209aef79130	keyUse	ENC
b5379de1-c394-4075-8f91-88c5990e370d	b302702d-d2eb-43de-8d25-5209aef79130	algorithm	RSA-OAEP
90a4615b-d98d-4dfb-92cd-95571d2ad5a6	b302702d-d2eb-43de-8d25-5209aef79130	priority	100
a1c7f42e-0664-4aaf-8de0-a6db7f60d435	b302702d-d2eb-43de-8d25-5209aef79130	certificate	MIICmTCCAYECBgGVf21bljANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVhaG1lZDAeFw0yNTAzMTAwOTM4NDhaFw0zNTAzMTAwOTQwMjhaMBAxDjAMBgNVBAMMBWFobWVkMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlhtyp59Uba5HvxRdX8bH8df3S12fpS+zPonDJaLhjB3hULy4DdNjK18NlTFURFXh+pIZdpuH0+rEK6z+hpT9p8AFIP1lbU2YrCvCrxBjuIQm7Vk1n0kCC2wf5KGvfG+mZK52BZL+mdzR4f+8mfKAW40ZNyORz4+b7LxgSP06SwtVbYiEFUIZ4MhwVqhrv5D8Pqj8ZWodJ7VffTJ6cVq4qJxwZGX6RFaHMrR4EeagtSH3/2CXcGrgYqhlTlXHX4raD3yUxXPBNpXZn1y6yT3HC7rtvwFHgYMTPM2XCVRHNhp7yceA8WBEM8coVSDnkK0hsQjOBUVnJC+iD2tfV+kk+QIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCHXnTtBmV3zDOgTm7mFHkyMvuRe7GyX1A7qzpHjP5poxAF114acGgWRoKe4j3BGUGHfzQu3enQFq4TQ9J69zzBP+WcWPNj6bSysaXLYLs/iEmcbS31Vpihe8j2Anrw7T3m2khwPBlvaWY8n+rx8qGhbGUD5opHQtQtQU8A7u3BCBlU0u3DgwUIPM6jP3cpXOhHPhvRyamOi7r90n7+fmJkODfA22DM2UtfPZKC6C83FY5XY8SeuKluYRLVLqAh8LbiY+8SIufQj/xl+VkOJqvrrTK5YXDguVUlkYeBXEOQ7G2hnuBlxYJgek0M/F7d/C60Y1gbT+mxplYW7V/yppUJ
56194151-9d3e-4306-9dac-4ad10fa256f2	eb7ac7b9-0443-4dda-920d-965d44d24eeb	allow-default-scopes	true
107482b7-e4db-4e93-8000-6ae0f6cfda3e	cdc01f93-bb1f-466d-8dd7-d02a26bee4b7	max-clients	200
529998ff-7cfc-4d96-9a5d-5f25fc4ff363	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
af45eaea-1e24-4b19-952a-8f7a847ebd1e	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	oidc-address-mapper
cdeb9d27-825a-48c7-bfa5-6de226b423d6	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	saml-role-list-mapper
8dc72157-1380-4574-8719-0c2ef0332605	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	saml-user-attribute-mapper
fdfd0962-343c-44b0-b4dd-77cb7706863e	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
cb521f63-f897-4230-ad4b-8a4f4d92f587	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	saml-user-property-mapper
241889c0-ce3a-45fd-a098-271e919352d1	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
acee719c-e83d-4b40-8b2f-f4402efd41f7	54fcc625-bf88-47bf-a458-41ff57c8987d	allowed-protocol-mapper-types	oidc-full-name-mapper
b050ff9f-2f66-46bd-971c-83b1ea72b9f6	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b6c794d5-37be-49f7-abc9-dfb9ff0070ef	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	oidc-address-mapper
af118c56-84b3-4259-bd7b-5942d7d58ec0	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8f1c4e95-5f23-43e2-b5b5-bd62761fb6fc	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	saml-user-property-mapper
91172ae6-f3cd-4dea-b553-54cd59dc2ccb	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d0ed1232-b906-465e-8725-8c32c0aa651a	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	saml-user-attribute-mapper
41ce6c93-5cef-4ac9-8269-54a8a80e3dae	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	oidc-full-name-mapper
fc067346-8d3c-49f0-9cb7-f59f234b092b	df6d755d-655a-42ea-bc46-fa897fd3749a	allowed-protocol-mapper-types	saml-role-list-mapper
5978823b-5c9d-4f82-a7d3-ebf4ad25f1e9	cb14d23e-bd56-4e1c-9cca-04dc48f558b0	client-uris-must-match	true
51751106-0453-40bc-bb90-e41011ab09f0	cb14d23e-bd56-4e1c-9cca-04dc48f558b0	host-sending-registration-request-must-match	true
b7261a23-1048-4dc4-9f00-6fb606790dea	2e68a6d5-0827-4c5f-81ca-095e27445305	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
a3d30c56-893c-4733-9404-14455521e2d2	fa771fb6-8086-4190-a083-17c8b6e98cb1
a3d30c56-893c-4733-9404-14455521e2d2	1712c408-3711-4988-a532-96508fb3e9cf
a3d30c56-893c-4733-9404-14455521e2d2	aafadf15-1f6a-44e0-ae6e-cc5f673c9382
a3d30c56-893c-4733-9404-14455521e2d2	eaa07fd5-0d7d-47e1-ad9e-b79818ff7e10
a3d30c56-893c-4733-9404-14455521e2d2	3a177f65-7cff-4103-9c08-8444a403bd50
a3d30c56-893c-4733-9404-14455521e2d2	012e70b1-f19c-4f3c-b8a5-80561c69a433
a3d30c56-893c-4733-9404-14455521e2d2	141c29e4-08a5-4747-bb04-022c0ae1f073
a3d30c56-893c-4733-9404-14455521e2d2	9491cd38-57b3-426a-92d0-129ead3efd61
a3d30c56-893c-4733-9404-14455521e2d2	771b7d2d-9499-4ae1-8e65-443da2d83a29
a3d30c56-893c-4733-9404-14455521e2d2	94162ea3-e261-4e9b-9666-5a60af38ff82
a3d30c56-893c-4733-9404-14455521e2d2	c8dc3f5e-0fd7-48a7-9797-daa68d192ac8
a3d30c56-893c-4733-9404-14455521e2d2	91069e2f-8972-48f1-8966-44a8675db182
a3d30c56-893c-4733-9404-14455521e2d2	5c8d6e65-1b64-4b90-88d4-04045feaf673
a3d30c56-893c-4733-9404-14455521e2d2	4a3da05a-d4e4-44e7-8806-dab7e3e76158
a3d30c56-893c-4733-9404-14455521e2d2	2e624874-6cf6-466e-979e-cdb881905366
a3d30c56-893c-4733-9404-14455521e2d2	63364354-d767-460d-adf4-62e0f267072f
a3d30c56-893c-4733-9404-14455521e2d2	1118538d-7f46-4196-aeea-8617e685a8e1
a3d30c56-893c-4733-9404-14455521e2d2	97c9d1a6-f1c7-4587-bb15-f60902a15124
3a177f65-7cff-4103-9c08-8444a403bd50	63364354-d767-460d-adf4-62e0f267072f
84d40434-6659-4c99-950b-f8348db6c316	3e192cae-6bae-4afd-a44a-a98151b529ec
eaa07fd5-0d7d-47e1-ad9e-b79818ff7e10	97c9d1a6-f1c7-4587-bb15-f60902a15124
eaa07fd5-0d7d-47e1-ad9e-b79818ff7e10	2e624874-6cf6-466e-979e-cdb881905366
84d40434-6659-4c99-950b-f8348db6c316	e6115ace-e4c1-4c55-9db0-7b726150645a
e6115ace-e4c1-4c55-9db0-7b726150645a	f9fabfd5-9570-487e-a7b1-75904829330d
2e1c436d-0f41-40da-9771-c7459cf4ba52	38cf2a1e-be9d-4c7f-9a8d-4ca2b7dbf79c
a3d30c56-893c-4733-9404-14455521e2d2	7eb6e483-3694-41fd-b8fb-b96a6bf9dac6
84d40434-6659-4c99-950b-f8348db6c316	143d6a37-85fe-4734-9c57-394f7535efa1
84d40434-6659-4c99-950b-f8348db6c316	ab3220f5-80c2-4537-901c-5944258b82a2
a3d30c56-893c-4733-9404-14455521e2d2	356abad9-0a5a-4a91-b0e0-de0abfc59a04
a3d30c56-893c-4733-9404-14455521e2d2	4051eca7-c5e8-4e0e-9e39-7785786b2f6c
a3d30c56-893c-4733-9404-14455521e2d2	64990d2e-eb90-4721-8473-bc989f3ffa1b
a3d30c56-893c-4733-9404-14455521e2d2	d3f33d70-7f24-4ce1-9990-30b77793f20a
a3d30c56-893c-4733-9404-14455521e2d2	a47bccd6-c966-476f-8b52-a9826b10b8d5
a3d30c56-893c-4733-9404-14455521e2d2	c0019dfc-cdb9-4544-afa1-d6c1226f874d
a3d30c56-893c-4733-9404-14455521e2d2	20e6d8a6-a639-4f5b-9734-3794d290a638
a3d30c56-893c-4733-9404-14455521e2d2	00a07ed6-c346-4068-9364-e3f25c634c3e
a3d30c56-893c-4733-9404-14455521e2d2	6c789f3a-de7d-486b-8c9d-631b6c811739
a3d30c56-893c-4733-9404-14455521e2d2	a5582631-0bd9-45e4-af2d-2308b163531d
a3d30c56-893c-4733-9404-14455521e2d2	ec723ab2-a4ae-482b-abfa-210ddc0f73eb
a3d30c56-893c-4733-9404-14455521e2d2	e95ae058-dcf2-4222-858c-efbc26da0587
a3d30c56-893c-4733-9404-14455521e2d2	3477210d-791d-430e-9607-523e1a436ccf
a3d30c56-893c-4733-9404-14455521e2d2	cf9b9d82-bd58-4d1a-ba97-273dcf9586c1
a3d30c56-893c-4733-9404-14455521e2d2	6fe1310c-43a8-492f-9cc3-048b06714aa1
a3d30c56-893c-4733-9404-14455521e2d2	e9268f1a-5873-47c6-85ab-d1e52d92fd00
a3d30c56-893c-4733-9404-14455521e2d2	7d77c5f8-366e-4e2d-97e6-f3f22230d860
64990d2e-eb90-4721-8473-bc989f3ffa1b	cf9b9d82-bd58-4d1a-ba97-273dcf9586c1
64990d2e-eb90-4721-8473-bc989f3ffa1b	7d77c5f8-366e-4e2d-97e6-f3f22230d860
d3f33d70-7f24-4ce1-9990-30b77793f20a	6fe1310c-43a8-492f-9cc3-048b06714aa1
aafc19eb-34f0-46b0-aa37-74d93330c388	6bd03d7f-bb3f-435f-b9a9-5468e9b7005f
aafc19eb-34f0-46b0-aa37-74d93330c388	7ff0646a-4ce4-4cf4-9b0e-a64a54511f98
aafc19eb-34f0-46b0-aa37-74d93330c388	ec54c931-d2aa-44b0-9718-521b062ef3d5
aafc19eb-34f0-46b0-aa37-74d93330c388	301e4169-bad5-4c68-9016-102c841c7cd5
aafc19eb-34f0-46b0-aa37-74d93330c388	dcd4b53d-f24a-4543-9dd0-5ae42fccca1d
aafc19eb-34f0-46b0-aa37-74d93330c388	f9138572-05d3-444d-a3da-38798589ba2d
aafc19eb-34f0-46b0-aa37-74d93330c388	76618191-0ca3-402c-a34b-ec70e94be01a
aafc19eb-34f0-46b0-aa37-74d93330c388	b767cf82-6501-451a-9554-7a9c11609034
aafc19eb-34f0-46b0-aa37-74d93330c388	0a760264-2898-49ea-98d9-eb58a2bc5878
aafc19eb-34f0-46b0-aa37-74d93330c388	3dfc5eed-e5d5-41a8-935e-932fa6898672
aafc19eb-34f0-46b0-aa37-74d93330c388	b6ca4481-6d86-4a51-96a7-5400089e976f
aafc19eb-34f0-46b0-aa37-74d93330c388	8f7e1af0-eea1-4c61-950f-b26dcc3ab03e
aafc19eb-34f0-46b0-aa37-74d93330c388	a237a077-f1d0-45f0-8d48-83fc186dfddc
aafc19eb-34f0-46b0-aa37-74d93330c388	87911f2c-54f2-4482-b8a1-4d723c6b100a
aafc19eb-34f0-46b0-aa37-74d93330c388	fea13779-8f99-4d46-b66d-d944facf20de
aafc19eb-34f0-46b0-aa37-74d93330c388	154916a7-00bc-4426-8491-bac6869d9aa8
aafc19eb-34f0-46b0-aa37-74d93330c388	1ec91670-8650-49d1-ace8-5dd0aad829e9
301e4169-bad5-4c68-9016-102c841c7cd5	fea13779-8f99-4d46-b66d-d944facf20de
65fd8bcd-250a-4a80-a33f-2b497aafc5b5	8721adec-5aa1-446e-9c76-4186b73bac39
ec54c931-d2aa-44b0-9718-521b062ef3d5	1ec91670-8650-49d1-ace8-5dd0aad829e9
ec54c931-d2aa-44b0-9718-521b062ef3d5	87911f2c-54f2-4482-b8a1-4d723c6b100a
65fd8bcd-250a-4a80-a33f-2b497aafc5b5	452d2071-40c2-4a42-8e30-9f42d13a3262
452d2071-40c2-4a42-8e30-9f42d13a3262	5c5e91f3-0897-448e-8316-f4f3ef262adf
c08b9132-6921-4457-977a-6592f2982586	ce2ae1a8-cfc2-45cb-9267-f3c107b06220
a3d30c56-893c-4733-9404-14455521e2d2	fcdac830-295a-499e-a63d-daa1e3888a15
aafc19eb-34f0-46b0-aa37-74d93330c388	40f8198f-52cf-4000-bbb9-91a39da81dd1
65fd8bcd-250a-4a80-a33f-2b497aafc5b5	4acb8774-0b01-4d7f-afb2-e3db0e71c3d3
65fd8bcd-250a-4a80-a33f-2b497aafc5b5	cb988bfc-24e5-4ff3-9455-cdea32880813
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
7e4ed6de-31bc-496b-83b0-4ebde72b5dc3	\N	password	5f80f096-64f1-4488-bd03-e2cbf8b13f14	1741437164533	\N	{"value":"F7eQNk0WIkK1ICYQ53KAAgYJy2Rp0yapohtAc4IBJrI=","salt":"0mCJ33ZxZzY1It8IpbLWUQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-03-08 12:32:35.266395	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1437154760
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-03-08 12:32:35.287655	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1437154760
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-03-08 12:32:35.344703	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	1437154760
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-03-08 12:32:35.354331	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1437154760
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-03-08 12:32:35.49143	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1437154760
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-03-08 12:32:35.499792	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1437154760
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-03-08 12:32:35.605949	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1437154760
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-03-08 12:32:35.610815	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1437154760
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-03-08 12:32:35.617261	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	1437154760
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-03-08 12:32:35.710475	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	1437154760
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-03-08 12:32:35.761959	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1437154760
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-03-08 12:32:35.766463	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1437154760
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-03-08 12:32:35.78492	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1437154760
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-08 12:32:35.806419	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	1437154760
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-08 12:32:35.808465	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-08 12:32:35.811058	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	1437154760
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-08 12:32:35.813808	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	1437154760
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-03-08 12:32:35.861017	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	1437154760
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-03-08 12:32:35.907462	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1437154760
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-03-08 12:32:35.914326	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1437154760
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-08 12:32:35.918011	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1437154760
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-08 12:32:35.921733	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1437154760
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-03-08 12:32:35.994238	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	1437154760
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-03-08 12:32:36.000228	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1437154760
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-03-08 12:32:36.002763	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1437154760
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-03-08 12:32:36.403591	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	1437154760
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-03-08 12:32:36.489456	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	1437154760
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-03-08 12:32:36.49404	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1437154760
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-03-08 12:32:36.575183	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	1437154760
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-03-08 12:32:36.590489	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	1437154760
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-03-08 12:32:36.609862	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	1437154760
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-03-08 12:32:36.615167	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	1437154760
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-08 12:32:36.620908	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-08 12:32:36.623333	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1437154760
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-08 12:32:36.652155	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1437154760
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-03-08 12:32:36.65901	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	1437154760
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-08 12:32:36.665041	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1437154760
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-03-08 12:32:36.669069	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	1437154760
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-03-08 12:32:36.674051	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	1437154760
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-08 12:32:36.675549	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1437154760
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-08 12:32:36.677749	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1437154760
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-03-08 12:32:36.682454	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	1437154760
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-08 12:32:38.02932	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	1437154760
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-03-08 12:32:38.033553	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	1437154760
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-08 12:32:38.038631	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1437154760
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-08 12:32:38.042254	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	1437154760
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-08 12:32:38.043748	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1437154760
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-08 12:32:38.160488	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	1437154760
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-08 12:32:38.164077	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	1437154760
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-03-08 12:32:38.206541	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	1437154760
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-03-08 12:32:38.628421	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	1437154760
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-03-08 12:32:38.631931	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-03-08 12:32:38.634557	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	1437154760
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-03-08 12:32:38.63725	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	1437154760
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-08 12:32:38.644335	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	1437154760
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-08 12:32:38.648783	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	1437154760
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-08 12:32:38.692501	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	1437154760
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-08 12:32:39.065295	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	1437154760
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-03-08 12:32:39.090837	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	1437154760
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-03-08 12:32:39.095295	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1437154760
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-08 12:32:39.102749	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	1437154760
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-08 12:32:39.107768	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	1437154760
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-03-08 12:32:39.110729	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1437154760
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-03-08 12:32:39.113202	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1437154760
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-08 12:32:39.115448	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	1437154760
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-03-08 12:32:39.154708	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	1437154760
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-08 12:32:39.185592	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	1437154760
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-03-08 12:32:39.189488	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	1437154760
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-03-08 12:32:39.225004	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	1437154760
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-03-08 12:32:39.229623	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	1437154760
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-03-08 12:32:39.233505	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1437154760
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-08 12:32:39.239685	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1437154760
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-08 12:32:39.24776	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1437154760
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-08 12:32:39.249813	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1437154760
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-08 12:32:39.264475	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	1437154760
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-08 12:32:39.30007	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	1437154760
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-08 12:32:39.304609	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	1437154760
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-08 12:32:39.306211	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	1437154760
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-08 12:32:39.323035	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	1437154760
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-08 12:32:39.324767	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	1437154760
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-08 12:32:39.359843	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	1437154760
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-08 12:32:39.361501	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1437154760
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-08 12:32:39.365796	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1437154760
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-08 12:32:39.367306	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1437154760
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-08 12:32:39.407343	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1437154760
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-03-08 12:32:39.412322	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	1437154760
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-08 12:32:39.419183	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	1437154760
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-08 12:32:39.428953	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	1437154760
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.434088	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	1437154760
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.439223	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	1437154760
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.49018	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.496141	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	1437154760
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.498269	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1437154760
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.50952	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1437154760
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.511353	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	1437154760
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-08 12:32:39.517207	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	1437154760
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-08 12:32:39.607877	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-08 12:32:39.609499	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-08 12:32:39.622452	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-08 12:32:39.659982	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-08 12:32:39.662336	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-08 12:32:39.707267	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	1437154760
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-08 12:32:39.712368	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	1437154760
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-03-08 12:32:39.719547	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	1437154760
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-03-08 12:32:39.758939	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	1437154760
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-03-08 12:32:39.798535	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1437154760
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-03-08 12:32:39.845688	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	1437154760
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-03-08 12:32:39.850936	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	1437154760
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-08 12:32:39.903472	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1437154760
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-08 12:32:39.906297	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1437154760
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-08 12:32:39.917601	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-03-08 12:32:39.924383	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	1437154760
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-08 12:32:39.963398	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1437154760
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-08 12:32:39.967978	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	1437154760
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-08 12:32:39.975338	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	1437154760
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-08 12:32:39.978866	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	1437154760
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-08 12:32:39.991323	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	1437154760
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-08 12:32:39.999997	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1437154760
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-08 12:32:40.200593	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	1437154760
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-08 12:32:40.203946	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	1437154760
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-08 12:32:40.208191	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-08 12:32:40.241783	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-08 12:32:40.245095	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	1437154760
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-08 12:32:40.246646	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-08 12:32:40.248373	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.252597	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.283304	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.341426	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.392767	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.441809	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.498217	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.500999	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.553975	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1437154760
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.57788	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1437154760
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.590941	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1437154760
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.592936	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1437154760
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-08 12:32:40.666428	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	1437154760
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.673504	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	1437154760
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.681116	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	1437154760
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.714614	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1437154760
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.71973	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	1437154760
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.726785	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1437154760
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.761675	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1437154760
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.829884	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	1437154760
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.867424	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1437154760
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.876394	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	1437154760
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-08 12:32:40.879547	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	1437154760
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-03-08 12:32:40.888094	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	1437154760
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-03-08 12:32:40.896258	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1437154760
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-03-08 12:32:40.899668	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	1437154760
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
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
5000cf22-fc94-4d79-8942-f7e575263547	dd263562-f229-4aa7-aabe-2408a5492950	f
5000cf22-fc94-4d79-8942-f7e575263547	4c7470e9-452c-4694-b7c5-23247d27d610	t
5000cf22-fc94-4d79-8942-f7e575263547	d4d5ac14-28f1-41bc-808a-28156da6fc7a	t
5000cf22-fc94-4d79-8942-f7e575263547	af191aa0-1251-4d98-be15-5f2afaf1d788	t
5000cf22-fc94-4d79-8942-f7e575263547	1fefb907-66ad-46a8-9cad-bb2e529b53a9	t
5000cf22-fc94-4d79-8942-f7e575263547	c75b41ce-1b63-4b30-b163-636432ffaa0c	f
5000cf22-fc94-4d79-8942-f7e575263547	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3	f
5000cf22-fc94-4d79-8942-f7e575263547	4c7ce9bf-6af3-4769-9b1e-7065526bef8a	t
5000cf22-fc94-4d79-8942-f7e575263547	5cb25839-3782-4365-b63c-9045efba34fe	t
5000cf22-fc94-4d79-8942-f7e575263547	7e7ab024-9d58-4a5f-9602-2c836a8dce4e	f
5000cf22-fc94-4d79-8942-f7e575263547	32016b06-96c7-4a34-9c8f-d48edaf6c221	t
5000cf22-fc94-4d79-8942-f7e575263547	1755f152-fdac-4ab5-aaa0-d58034fd4151	t
5000cf22-fc94-4d79-8942-f7e575263547	23cd1bc8-c9e8-4add-ad4e-71dae75661c1	f
64ff6a29-5a1a-4538-bfe4-ab59163e838a	5f93bbee-0bb7-4a59-a7c3-95a62b8df36d	f
64ff6a29-5a1a-4538-bfe4-ab59163e838a	1ae48abb-2969-4ad4-a910-f65ac6634a0d	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	413732d1-e97f-4fb0-9582-b3a6aba198d2	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	32273d52-cd80-4329-9b89-1408cb99151c	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	56d755bf-b702-43b4-ab26-f4076ba472b4	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	d0f81eaa-0793-493f-bb94-634232d5a6f1	f
64ff6a29-5a1a-4538-bfe4-ab59163e838a	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab	f
64ff6a29-5a1a-4538-bfe4-ab59163e838a	a137ea02-90aa-4aa2-b06f-10cb5c969ade	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	b2079f16-618e-40a0-abe8-91d2b3284528	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8	f
64ff6a29-5a1a-4538-bfe4-ab59163e838a	41cf9bde-5780-49ea-93d3-b0eca6cf1afe	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	067e9ca0-7139-4220-8f64-846a3b20e5a4	t
64ff6a29-5a1a-4538-bfe4-ab59163e838a	f34952aa-3de7-4199-b0b7-f85ee917768f	f
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

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
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
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
84d40434-6659-4c99-950b-f8348db6c316	5000cf22-fc94-4d79-8942-f7e575263547	f	${role_default-roles}	default-roles-master	5000cf22-fc94-4d79-8942-f7e575263547	\N	\N
a3d30c56-893c-4733-9404-14455521e2d2	5000cf22-fc94-4d79-8942-f7e575263547	f	${role_admin}	admin	5000cf22-fc94-4d79-8942-f7e575263547	\N	\N
fa771fb6-8086-4190-a083-17c8b6e98cb1	5000cf22-fc94-4d79-8942-f7e575263547	f	${role_create-realm}	create-realm	5000cf22-fc94-4d79-8942-f7e575263547	\N	\N
1712c408-3711-4988-a532-96508fb3e9cf	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_create-client}	create-client	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
aafadf15-1f6a-44e0-ae6e-cc5f673c9382	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_view-realm}	view-realm	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
eaa07fd5-0d7d-47e1-ad9e-b79818ff7e10	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_view-users}	view-users	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
3a177f65-7cff-4103-9c08-8444a403bd50	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_view-clients}	view-clients	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
012e70b1-f19c-4f3c-b8a5-80561c69a433	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_view-events}	view-events	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
141c29e4-08a5-4747-bb04-022c0ae1f073	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_view-identity-providers}	view-identity-providers	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
9491cd38-57b3-426a-92d0-129ead3efd61	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_view-authorization}	view-authorization	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
771b7d2d-9499-4ae1-8e65-443da2d83a29	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_manage-realm}	manage-realm	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
94162ea3-e261-4e9b-9666-5a60af38ff82	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_manage-users}	manage-users	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
c8dc3f5e-0fd7-48a7-9797-daa68d192ac8	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_manage-clients}	manage-clients	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
91069e2f-8972-48f1-8966-44a8675db182	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_manage-events}	manage-events	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
5c8d6e65-1b64-4b90-88d4-04045feaf673	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_manage-identity-providers}	manage-identity-providers	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
4a3da05a-d4e4-44e7-8806-dab7e3e76158	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_manage-authorization}	manage-authorization	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
2e624874-6cf6-466e-979e-cdb881905366	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_query-users}	query-users	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
63364354-d767-460d-adf4-62e0f267072f	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_query-clients}	query-clients	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
1118538d-7f46-4196-aeea-8617e685a8e1	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_query-realms}	query-realms	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
97c9d1a6-f1c7-4587-bb15-f60902a15124	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_query-groups}	query-groups	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
3e192cae-6bae-4afd-a44a-a98151b529ec	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_view-profile}	view-profile	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
e6115ace-e4c1-4c55-9db0-7b726150645a	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_manage-account}	manage-account	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
f9fabfd5-9570-487e-a7b1-75904829330d	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_manage-account-links}	manage-account-links	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
18bd9512-e61b-4ab1-ba8c-51c2ae7c3852	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_view-applications}	view-applications	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
38cf2a1e-be9d-4c7f-9a8d-4ca2b7dbf79c	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_view-consent}	view-consent	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
2e1c436d-0f41-40da-9771-c7459cf4ba52	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_manage-consent}	manage-consent	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
8391294c-19ae-495b-bb35-74b7248ff408	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_view-groups}	view-groups	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
06684c32-55ca-4c9d-9b84-ed11f0174d7f	599987ac-15a6-4633-ad5a-2e8f7cd44d26	t	${role_delete-account}	delete-account	5000cf22-fc94-4d79-8942-f7e575263547	599987ac-15a6-4633-ad5a-2e8f7cd44d26	\N
badf26f1-12b5-425b-91fc-f7b384b8b165	bc538955-b97c-4c03-a371-48e6eac20493	t	${role_read-token}	read-token	5000cf22-fc94-4d79-8942-f7e575263547	bc538955-b97c-4c03-a371-48e6eac20493	\N
7eb6e483-3694-41fd-b8fb-b96a6bf9dac6	4a84d94c-77b7-46a2-baff-eecd72ed7d76	t	${role_impersonation}	impersonation	5000cf22-fc94-4d79-8942-f7e575263547	4a84d94c-77b7-46a2-baff-eecd72ed7d76	\N
143d6a37-85fe-4734-9c57-394f7535efa1	5000cf22-fc94-4d79-8942-f7e575263547	f	${role_offline-access}	offline_access	5000cf22-fc94-4d79-8942-f7e575263547	\N	\N
ab3220f5-80c2-4537-901c-5944258b82a2	5000cf22-fc94-4d79-8942-f7e575263547	f	${role_uma_authorization}	uma_authorization	5000cf22-fc94-4d79-8942-f7e575263547	\N	\N
65fd8bcd-250a-4a80-a33f-2b497aafc5b5	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f	${role_default-roles}	default-roles-ahmed	64ff6a29-5a1a-4538-bfe4-ab59163e838a	\N	\N
356abad9-0a5a-4a91-b0e0-de0abfc59a04	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_create-client}	create-client	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
4051eca7-c5e8-4e0e-9e39-7785786b2f6c	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_view-realm}	view-realm	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
64990d2e-eb90-4721-8473-bc989f3ffa1b	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_view-users}	view-users	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
d3f33d70-7f24-4ce1-9990-30b77793f20a	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_view-clients}	view-clients	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
a47bccd6-c966-476f-8b52-a9826b10b8d5	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_view-events}	view-events	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
c0019dfc-cdb9-4544-afa1-d6c1226f874d	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_view-identity-providers}	view-identity-providers	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
20e6d8a6-a639-4f5b-9734-3794d290a638	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_view-authorization}	view-authorization	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
00a07ed6-c346-4068-9364-e3f25c634c3e	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_manage-realm}	manage-realm	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
6c789f3a-de7d-486b-8c9d-631b6c811739	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_manage-users}	manage-users	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
a5582631-0bd9-45e4-af2d-2308b163531d	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_manage-clients}	manage-clients	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
ec723ab2-a4ae-482b-abfa-210ddc0f73eb	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_manage-events}	manage-events	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
e95ae058-dcf2-4222-858c-efbc26da0587	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_manage-identity-providers}	manage-identity-providers	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
3477210d-791d-430e-9607-523e1a436ccf	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_manage-authorization}	manage-authorization	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
cf9b9d82-bd58-4d1a-ba97-273dcf9586c1	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_query-users}	query-users	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
6fe1310c-43a8-492f-9cc3-048b06714aa1	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_query-clients}	query-clients	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
e9268f1a-5873-47c6-85ab-d1e52d92fd00	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_query-realms}	query-realms	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
7d77c5f8-366e-4e2d-97e6-f3f22230d860	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_query-groups}	query-groups	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
aafc19eb-34f0-46b0-aa37-74d93330c388	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_realm-admin}	realm-admin	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
6bd03d7f-bb3f-435f-b9a9-5468e9b7005f	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_create-client}	create-client	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
7ff0646a-4ce4-4cf4-9b0e-a64a54511f98	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_view-realm}	view-realm	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
ec54c931-d2aa-44b0-9718-521b062ef3d5	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_view-users}	view-users	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
301e4169-bad5-4c68-9016-102c841c7cd5	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_view-clients}	view-clients	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
dcd4b53d-f24a-4543-9dd0-5ae42fccca1d	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_view-events}	view-events	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
f9138572-05d3-444d-a3da-38798589ba2d	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_view-identity-providers}	view-identity-providers	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
76618191-0ca3-402c-a34b-ec70e94be01a	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_view-authorization}	view-authorization	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
b767cf82-6501-451a-9554-7a9c11609034	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_manage-realm}	manage-realm	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
0a760264-2898-49ea-98d9-eb58a2bc5878	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_manage-users}	manage-users	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
3dfc5eed-e5d5-41a8-935e-932fa6898672	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_manage-clients}	manage-clients	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
b6ca4481-6d86-4a51-96a7-5400089e976f	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_manage-events}	manage-events	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
8f7e1af0-eea1-4c61-950f-b26dcc3ab03e	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_manage-identity-providers}	manage-identity-providers	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
a237a077-f1d0-45f0-8d48-83fc186dfddc	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_manage-authorization}	manage-authorization	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
87911f2c-54f2-4482-b8a1-4d723c6b100a	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_query-users}	query-users	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
fea13779-8f99-4d46-b66d-d944facf20de	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_query-clients}	query-clients	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
154916a7-00bc-4426-8491-bac6869d9aa8	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_query-realms}	query-realms	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
1ec91670-8650-49d1-ace8-5dd0aad829e9	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_query-groups}	query-groups	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
8721adec-5aa1-446e-9c76-4186b73bac39	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_view-profile}	view-profile	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
452d2071-40c2-4a42-8e30-9f42d13a3262	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_manage-account}	manage-account	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
5c5e91f3-0897-448e-8316-f4f3ef262adf	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_manage-account-links}	manage-account-links	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
aecdc37b-ee50-42d8-bcb6-0e0cba86ea5a	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_view-applications}	view-applications	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
ce2ae1a8-cfc2-45cb-9267-f3c107b06220	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_view-consent}	view-consent	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
c08b9132-6921-4457-977a-6592f2982586	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_manage-consent}	manage-consent	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
a9e97990-aac0-44f3-8c21-d70a2cb578c2	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_view-groups}	view-groups	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
8508f626-8bd4-44eb-abd9-6fbbb25f676a	cdd47509-7308-47bf-83cc-bebf9cb8a613	t	${role_delete-account}	delete-account	64ff6a29-5a1a-4538-bfe4-ab59163e838a	cdd47509-7308-47bf-83cc-bebf9cb8a613	\N
fcdac830-295a-499e-a63d-daa1e3888a15	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	t	${role_impersonation}	impersonation	5000cf22-fc94-4d79-8942-f7e575263547	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	\N
40f8198f-52cf-4000-bbb9-91a39da81dd1	b547a77a-5e91-48a1-8288-0c44881a9054	t	${role_impersonation}	impersonation	64ff6a29-5a1a-4538-bfe4-ab59163e838a	b547a77a-5e91-48a1-8288-0c44881a9054	\N
1d8a9713-bf7c-42b0-89f1-3874d0bd2870	ad124807-36c5-434e-8fc3-089d4c67ba45	t	${role_read-token}	read-token	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ad124807-36c5-434e-8fc3-089d4c67ba45	\N
4acb8774-0b01-4d7f-afb2-e3db0e71c3d3	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f	${role_offline-access}	offline_access	64ff6a29-5a1a-4538-bfe4-ab59163e838a	\N	\N
cb988bfc-24e5-4ff3-9455-cdea32880813	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f	${role_uma_authorization}	uma_authorization	64ff6a29-5a1a-4538-bfe4-ab59163e838a	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.migration_model (id, version, update_time) FROM stdin;
xlaom	26.1.3	1741437161
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
49f101c4-b322-456b-9330-37f6f7e046fc	audience resolve	openid-connect	oidc-audience-resolve-mapper	f205166f-d4fb-481e-a5c1-4ee8cffb2906	\N
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	locale	openid-connect	oidc-usermodel-attribute-mapper	7804a2f3-c8ff-4afc-9a61-49837f83353d	\N
5c9ee8de-cba3-4577-b209-cee175bd1143	role list	saml	saml-role-list-mapper	\N	4c7470e9-452c-4694-b7c5-23247d27d610
a4296e37-2d24-4a1c-bc17-3d5c935f6111	organization	saml	saml-organization-membership-mapper	\N	d4d5ac14-28f1-41bc-808a-28156da6fc7a
469a652b-1995-432d-8953-7d31500bd67b	full name	openid-connect	oidc-full-name-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
17bb4624-ccf5-4df4-9d50-7ee37d435405	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
1278ae0d-0077-45a5-90a1-01a4d8589e73	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
9db97bbb-5536-461c-88f3-7c83635a55da	username	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
bd2f0b62-00e4-444b-926f-d354d7bd3718	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
cb36a0c4-344b-4979-801a-cdc535dd2c4f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
16db725c-06a2-4816-a3b0-d89c077174d8	website	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
3eaf96a8-4b48-44e5-875d-95df548109f3	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
c65b99a5-ac4f-4114-9745-39fa16c4134b	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
4160b781-cf27-4792-8a02-2d2c4347bd1e	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
1b69de73-84ab-42ab-a292-ca6e285f53f3	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
3d5218d4-e8f0-4961-9509-250b78a39f2e	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	af191aa0-1251-4d98-be15-5f2afaf1d788
f09f6f02-6104-4e94-b75a-82789d9a998b	email	openid-connect	oidc-usermodel-attribute-mapper	\N	1fefb907-66ad-46a8-9cad-bb2e529b53a9
c488268d-f10f-4d0a-aad6-61503c5855c3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	1fefb907-66ad-46a8-9cad-bb2e529b53a9
35983e5c-7588-457b-88c7-7dae64c3eadd	address	openid-connect	oidc-address-mapper	\N	c75b41ce-1b63-4b30-b163-636432ffaa0c
41770fa2-f1f0-4201-b246-d6856552811e	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	aa7bde6b-aec0-43a4-a37a-70fb09b82ab3
9d8c4e00-e36d-4b0f-9eed-8a58cc2a1d0a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	4c7ce9bf-6af3-4769-9b1e-7065526bef8a
9ec0178e-d630-48a4-abec-87fb07d48282	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	4c7ce9bf-6af3-4769-9b1e-7065526bef8a
bb5ffb24-1fe4-4114-87cb-99e744dade14	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	4c7ce9bf-6af3-4769-9b1e-7065526bef8a
11e04697-bdb5-4a8a-99c1-5649276be46f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5cb25839-3782-4365-b63c-9045efba34fe
47696807-1081-4b30-845e-bcf27eb93f40	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	7e7ab024-9d58-4a5f-9602-2c836a8dce4e
9d5f1426-3b15-471b-9e14-45a1b5958b5a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	7e7ab024-9d58-4a5f-9602-2c836a8dce4e
af29a342-e1fc-4275-bf30-b688bfca3566	acr loa level	openid-connect	oidc-acr-mapper	\N	32016b06-96c7-4a34-9c8f-d48edaf6c221
79b17f36-2a3a-4da5-a2a6-79cb2c634971	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	1755f152-fdac-4ab5-aaa0-d58034fd4151
7018006e-d4fd-4de0-b53b-5afe0ae5796e	sub	openid-connect	oidc-sub-mapper	\N	1755f152-fdac-4ab5-aaa0-d58034fd4151
2858f5db-bd4b-451f-81f7-9d45ae02c839	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	e3998e0c-368e-4541-8e9b-1eb54fd3434f
c657e44f-453b-407b-8605-71863cb1ec7b	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	e3998e0c-368e-4541-8e9b-1eb54fd3434f
cf37053f-79de-4d65-adea-fdeeedfab18b	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	e3998e0c-368e-4541-8e9b-1eb54fd3434f
10d4588b-9936-408c-8b4e-f7b63d622e9e	organization	openid-connect	oidc-organization-membership-mapper	\N	23cd1bc8-c9e8-4add-ad4e-71dae75661c1
47e1f4a2-a6f7-4744-b305-10ffef412b3f	audience resolve	openid-connect	oidc-audience-resolve-mapper	7863fa10-ba9a-4cdd-aa72-70397455b30e	\N
8be2497d-5a4b-4af9-9365-d404b365b509	role list	saml	saml-role-list-mapper	\N	1ae48abb-2969-4ad4-a910-f65ac6634a0d
3b08fb35-7ebe-4f57-87a4-36dac88ae61f	organization	saml	saml-organization-membership-mapper	\N	413732d1-e97f-4fb0-9582-b3a6aba198d2
a726e2b2-2e3d-47cf-b9ba-5fca79fdbf0d	full name	openid-connect	oidc-full-name-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
4a162de3-c585-442b-ae11-7f35fbd73f5b	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
57af15c5-857a-41df-87ca-51b5d318aeef	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
67356456-6133-4303-9522-6cd0f542338a	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
886b6adb-7c19-4b9c-8e86-848f92451022	username	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
b1902104-c643-489c-8c1e-7829da0e42aa	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
43ab87f9-4118-4de6-9c0f-0eb1f8532451	website	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
7fd6b066-1256-41b5-b19b-5c08effdb518	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
2f3e15f0-495d-4711-b0dc-806e9ca1e592	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
711648de-2179-4808-ad67-75e22ae1497b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
267438e9-f430-4079-acb3-d3d5d2701522	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	32273d52-cd80-4329-9b89-1408cb99151c
8288c66d-3436-407e-88a3-a5af0a4a7d5b	email	openid-connect	oidc-usermodel-attribute-mapper	\N	56d755bf-b702-43b4-ab26-f4076ba472b4
6e742925-7193-44d5-9e16-1e3de7454e98	email verified	openid-connect	oidc-usermodel-property-mapper	\N	56d755bf-b702-43b4-ab26-f4076ba472b4
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	address	openid-connect	oidc-address-mapper	\N	d0f81eaa-0793-493f-bb94-634232d5a6f1
355b02e8-b127-4132-8ba6-624ad5dd87d7	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	730a6ded-3bc8-4468-a7d7-257f9fa6a0ab
34184151-93e5-46b8-9b67-68d3c527b7f5	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a137ea02-90aa-4aa2-b06f-10cb5c969ade
7e2bf72e-7428-4f18-bf0f-0a135cbcdfb8	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a137ea02-90aa-4aa2-b06f-10cb5c969ade
861caa38-4df0-4661-afc7-5e9b2915ebf3	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a137ea02-90aa-4aa2-b06f-10cb5c969ade
c1276f01-de4c-4bf4-9359-95c9e0457ea3	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	b2079f16-618e-40a0-abe8-91d2b3284528
f9908f03-12d1-4695-9382-c6c0e5260ecc	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8
788a22fa-68c4-48d1-98a6-2cc0130a9154	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	0a53ec5f-d57d-4e3f-bcb3-f640f6b8acb8
d881491d-32c3-4b10-a5de-15c8b932d6a8	acr loa level	openid-connect	oidc-acr-mapper	\N	41cf9bde-5780-49ea-93d3-b0eca6cf1afe
3d01604d-1dc3-42ff-bc1d-d221e06e80a9	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	067e9ca0-7139-4220-8f64-846a3b20e5a4
432c2798-857a-499c-93a5-f5d64ece18fb	sub	openid-connect	oidc-sub-mapper	\N	067e9ca0-7139-4220-8f64-846a3b20e5a4
f14500b3-256d-4013-a504-b459cd094db4	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	d3481c04-5c09-4b17-a2dc-b74a6d967a3a
5f2e6ca1-273a-4650-927d-8e37f338c993	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	d3481c04-5c09-4b17-a2dc-b74a6d967a3a
692d09ab-6d48-46b6-8d76-df7329b6d106	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	d3481c04-5c09-4b17-a2dc-b74a6d967a3a
cab208dd-4bab-4f5b-8710-1ce68ffaf2f0	organization	openid-connect	oidc-organization-membership-mapper	\N	f34952aa-3de7-4199-b0b7-f85ee917768f
a3733b3c-3223-43c1-869c-db95052a6cfc	locale	openid-connect	oidc-usermodel-attribute-mapper	92b2e86f-9e39-4e89-9c09-b56a0766785a	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	true	introspection.token.claim
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	true	userinfo.token.claim
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	locale	user.attribute
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	true	id.token.claim
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	true	access.token.claim
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	locale	claim.name
e93d91cf-9ae1-44ea-bf42-6238e8cf7f86	String	jsonType.label
5c9ee8de-cba3-4577-b209-cee175bd1143	false	single
5c9ee8de-cba3-4577-b209-cee175bd1143	Basic	attribute.nameformat
5c9ee8de-cba3-4577-b209-cee175bd1143	Role	attribute.name
1278ae0d-0077-45a5-90a1-01a4d8589e73	true	introspection.token.claim
1278ae0d-0077-45a5-90a1-01a4d8589e73	true	userinfo.token.claim
1278ae0d-0077-45a5-90a1-01a4d8589e73	nickname	user.attribute
1278ae0d-0077-45a5-90a1-01a4d8589e73	true	id.token.claim
1278ae0d-0077-45a5-90a1-01a4d8589e73	true	access.token.claim
1278ae0d-0077-45a5-90a1-01a4d8589e73	nickname	claim.name
1278ae0d-0077-45a5-90a1-01a4d8589e73	String	jsonType.label
16db725c-06a2-4816-a3b0-d89c077174d8	true	introspection.token.claim
16db725c-06a2-4816-a3b0-d89c077174d8	true	userinfo.token.claim
16db725c-06a2-4816-a3b0-d89c077174d8	website	user.attribute
16db725c-06a2-4816-a3b0-d89c077174d8	true	id.token.claim
16db725c-06a2-4816-a3b0-d89c077174d8	true	access.token.claim
16db725c-06a2-4816-a3b0-d89c077174d8	website	claim.name
16db725c-06a2-4816-a3b0-d89c077174d8	String	jsonType.label
17bb4624-ccf5-4df4-9d50-7ee37d435405	true	introspection.token.claim
17bb4624-ccf5-4df4-9d50-7ee37d435405	true	userinfo.token.claim
17bb4624-ccf5-4df4-9d50-7ee37d435405	middleName	user.attribute
17bb4624-ccf5-4df4-9d50-7ee37d435405	true	id.token.claim
17bb4624-ccf5-4df4-9d50-7ee37d435405	true	access.token.claim
17bb4624-ccf5-4df4-9d50-7ee37d435405	middle_name	claim.name
17bb4624-ccf5-4df4-9d50-7ee37d435405	String	jsonType.label
1b69de73-84ab-42ab-a292-ca6e285f53f3	true	introspection.token.claim
1b69de73-84ab-42ab-a292-ca6e285f53f3	true	userinfo.token.claim
1b69de73-84ab-42ab-a292-ca6e285f53f3	locale	user.attribute
1b69de73-84ab-42ab-a292-ca6e285f53f3	true	id.token.claim
1b69de73-84ab-42ab-a292-ca6e285f53f3	true	access.token.claim
1b69de73-84ab-42ab-a292-ca6e285f53f3	locale	claim.name
1b69de73-84ab-42ab-a292-ca6e285f53f3	String	jsonType.label
3d5218d4-e8f0-4961-9509-250b78a39f2e	true	introspection.token.claim
3d5218d4-e8f0-4961-9509-250b78a39f2e	true	userinfo.token.claim
3d5218d4-e8f0-4961-9509-250b78a39f2e	updatedAt	user.attribute
3d5218d4-e8f0-4961-9509-250b78a39f2e	true	id.token.claim
3d5218d4-e8f0-4961-9509-250b78a39f2e	true	access.token.claim
3d5218d4-e8f0-4961-9509-250b78a39f2e	updated_at	claim.name
3d5218d4-e8f0-4961-9509-250b78a39f2e	long	jsonType.label
3eaf96a8-4b48-44e5-875d-95df548109f3	true	introspection.token.claim
3eaf96a8-4b48-44e5-875d-95df548109f3	true	userinfo.token.claim
3eaf96a8-4b48-44e5-875d-95df548109f3	gender	user.attribute
3eaf96a8-4b48-44e5-875d-95df548109f3	true	id.token.claim
3eaf96a8-4b48-44e5-875d-95df548109f3	true	access.token.claim
3eaf96a8-4b48-44e5-875d-95df548109f3	gender	claim.name
3eaf96a8-4b48-44e5-875d-95df548109f3	String	jsonType.label
4160b781-cf27-4792-8a02-2d2c4347bd1e	true	introspection.token.claim
4160b781-cf27-4792-8a02-2d2c4347bd1e	true	userinfo.token.claim
4160b781-cf27-4792-8a02-2d2c4347bd1e	zoneinfo	user.attribute
4160b781-cf27-4792-8a02-2d2c4347bd1e	true	id.token.claim
4160b781-cf27-4792-8a02-2d2c4347bd1e	true	access.token.claim
4160b781-cf27-4792-8a02-2d2c4347bd1e	zoneinfo	claim.name
4160b781-cf27-4792-8a02-2d2c4347bd1e	String	jsonType.label
469a652b-1995-432d-8953-7d31500bd67b	true	introspection.token.claim
469a652b-1995-432d-8953-7d31500bd67b	true	userinfo.token.claim
469a652b-1995-432d-8953-7d31500bd67b	true	id.token.claim
469a652b-1995-432d-8953-7d31500bd67b	true	access.token.claim
9db97bbb-5536-461c-88f3-7c83635a55da	true	introspection.token.claim
9db97bbb-5536-461c-88f3-7c83635a55da	true	userinfo.token.claim
9db97bbb-5536-461c-88f3-7c83635a55da	username	user.attribute
9db97bbb-5536-461c-88f3-7c83635a55da	true	id.token.claim
9db97bbb-5536-461c-88f3-7c83635a55da	true	access.token.claim
9db97bbb-5536-461c-88f3-7c83635a55da	preferred_username	claim.name
9db97bbb-5536-461c-88f3-7c83635a55da	String	jsonType.label
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	true	introspection.token.claim
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	true	userinfo.token.claim
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	lastName	user.attribute
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	true	id.token.claim
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	true	access.token.claim
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	family_name	claim.name
baeedfdb-e7fb-4e4a-9b43-5a10fc3dc472	String	jsonType.label
bd2f0b62-00e4-444b-926f-d354d7bd3718	true	introspection.token.claim
bd2f0b62-00e4-444b-926f-d354d7bd3718	true	userinfo.token.claim
bd2f0b62-00e4-444b-926f-d354d7bd3718	profile	user.attribute
bd2f0b62-00e4-444b-926f-d354d7bd3718	true	id.token.claim
bd2f0b62-00e4-444b-926f-d354d7bd3718	true	access.token.claim
bd2f0b62-00e4-444b-926f-d354d7bd3718	profile	claim.name
bd2f0b62-00e4-444b-926f-d354d7bd3718	String	jsonType.label
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	true	introspection.token.claim
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	true	userinfo.token.claim
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	firstName	user.attribute
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	true	id.token.claim
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	true	access.token.claim
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	given_name	claim.name
c063fed4-0b5a-4ab7-9ee2-49ca3743418d	String	jsonType.label
c65b99a5-ac4f-4114-9745-39fa16c4134b	true	introspection.token.claim
c65b99a5-ac4f-4114-9745-39fa16c4134b	true	userinfo.token.claim
c65b99a5-ac4f-4114-9745-39fa16c4134b	birthdate	user.attribute
c65b99a5-ac4f-4114-9745-39fa16c4134b	true	id.token.claim
c65b99a5-ac4f-4114-9745-39fa16c4134b	true	access.token.claim
c65b99a5-ac4f-4114-9745-39fa16c4134b	birthdate	claim.name
c65b99a5-ac4f-4114-9745-39fa16c4134b	String	jsonType.label
cb36a0c4-344b-4979-801a-cdc535dd2c4f	true	introspection.token.claim
cb36a0c4-344b-4979-801a-cdc535dd2c4f	true	userinfo.token.claim
cb36a0c4-344b-4979-801a-cdc535dd2c4f	picture	user.attribute
cb36a0c4-344b-4979-801a-cdc535dd2c4f	true	id.token.claim
cb36a0c4-344b-4979-801a-cdc535dd2c4f	true	access.token.claim
cb36a0c4-344b-4979-801a-cdc535dd2c4f	picture	claim.name
cb36a0c4-344b-4979-801a-cdc535dd2c4f	String	jsonType.label
c488268d-f10f-4d0a-aad6-61503c5855c3	true	introspection.token.claim
c488268d-f10f-4d0a-aad6-61503c5855c3	true	userinfo.token.claim
c488268d-f10f-4d0a-aad6-61503c5855c3	emailVerified	user.attribute
c488268d-f10f-4d0a-aad6-61503c5855c3	true	id.token.claim
c488268d-f10f-4d0a-aad6-61503c5855c3	true	access.token.claim
c488268d-f10f-4d0a-aad6-61503c5855c3	email_verified	claim.name
c488268d-f10f-4d0a-aad6-61503c5855c3	boolean	jsonType.label
f09f6f02-6104-4e94-b75a-82789d9a998b	true	introspection.token.claim
f09f6f02-6104-4e94-b75a-82789d9a998b	true	userinfo.token.claim
f09f6f02-6104-4e94-b75a-82789d9a998b	email	user.attribute
f09f6f02-6104-4e94-b75a-82789d9a998b	true	id.token.claim
f09f6f02-6104-4e94-b75a-82789d9a998b	true	access.token.claim
f09f6f02-6104-4e94-b75a-82789d9a998b	email	claim.name
f09f6f02-6104-4e94-b75a-82789d9a998b	String	jsonType.label
35983e5c-7588-457b-88c7-7dae64c3eadd	formatted	user.attribute.formatted
35983e5c-7588-457b-88c7-7dae64c3eadd	country	user.attribute.country
35983e5c-7588-457b-88c7-7dae64c3eadd	true	introspection.token.claim
35983e5c-7588-457b-88c7-7dae64c3eadd	postal_code	user.attribute.postal_code
35983e5c-7588-457b-88c7-7dae64c3eadd	true	userinfo.token.claim
35983e5c-7588-457b-88c7-7dae64c3eadd	street	user.attribute.street
35983e5c-7588-457b-88c7-7dae64c3eadd	true	id.token.claim
35983e5c-7588-457b-88c7-7dae64c3eadd	region	user.attribute.region
35983e5c-7588-457b-88c7-7dae64c3eadd	true	access.token.claim
35983e5c-7588-457b-88c7-7dae64c3eadd	locality	user.attribute.locality
41770fa2-f1f0-4201-b246-d6856552811e	true	introspection.token.claim
41770fa2-f1f0-4201-b246-d6856552811e	true	userinfo.token.claim
41770fa2-f1f0-4201-b246-d6856552811e	phoneNumber	user.attribute
41770fa2-f1f0-4201-b246-d6856552811e	true	id.token.claim
41770fa2-f1f0-4201-b246-d6856552811e	true	access.token.claim
41770fa2-f1f0-4201-b246-d6856552811e	phone_number	claim.name
41770fa2-f1f0-4201-b246-d6856552811e	String	jsonType.label
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	true	introspection.token.claim
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	true	userinfo.token.claim
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	phoneNumberVerified	user.attribute
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	true	id.token.claim
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	true	access.token.claim
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	phone_number_verified	claim.name
bd6cd38d-0f93-4557-bdd5-23a3bc7949c4	boolean	jsonType.label
9d8c4e00-e36d-4b0f-9eed-8a58cc2a1d0a	true	introspection.token.claim
9d8c4e00-e36d-4b0f-9eed-8a58cc2a1d0a	true	multivalued
9d8c4e00-e36d-4b0f-9eed-8a58cc2a1d0a	foo	user.attribute
9d8c4e00-e36d-4b0f-9eed-8a58cc2a1d0a	true	access.token.claim
9d8c4e00-e36d-4b0f-9eed-8a58cc2a1d0a	realm_access.roles	claim.name
9d8c4e00-e36d-4b0f-9eed-8a58cc2a1d0a	String	jsonType.label
9ec0178e-d630-48a4-abec-87fb07d48282	true	introspection.token.claim
9ec0178e-d630-48a4-abec-87fb07d48282	true	multivalued
9ec0178e-d630-48a4-abec-87fb07d48282	foo	user.attribute
9ec0178e-d630-48a4-abec-87fb07d48282	true	access.token.claim
9ec0178e-d630-48a4-abec-87fb07d48282	resource_access.${client_id}.roles	claim.name
9ec0178e-d630-48a4-abec-87fb07d48282	String	jsonType.label
bb5ffb24-1fe4-4114-87cb-99e744dade14	true	introspection.token.claim
bb5ffb24-1fe4-4114-87cb-99e744dade14	true	access.token.claim
11e04697-bdb5-4a8a-99c1-5649276be46f	true	introspection.token.claim
11e04697-bdb5-4a8a-99c1-5649276be46f	true	access.token.claim
47696807-1081-4b30-845e-bcf27eb93f40	true	introspection.token.claim
47696807-1081-4b30-845e-bcf27eb93f40	true	userinfo.token.claim
47696807-1081-4b30-845e-bcf27eb93f40	username	user.attribute
47696807-1081-4b30-845e-bcf27eb93f40	true	id.token.claim
47696807-1081-4b30-845e-bcf27eb93f40	true	access.token.claim
47696807-1081-4b30-845e-bcf27eb93f40	upn	claim.name
47696807-1081-4b30-845e-bcf27eb93f40	String	jsonType.label
9d5f1426-3b15-471b-9e14-45a1b5958b5a	true	introspection.token.claim
9d5f1426-3b15-471b-9e14-45a1b5958b5a	true	multivalued
9d5f1426-3b15-471b-9e14-45a1b5958b5a	foo	user.attribute
9d5f1426-3b15-471b-9e14-45a1b5958b5a	true	id.token.claim
9d5f1426-3b15-471b-9e14-45a1b5958b5a	true	access.token.claim
9d5f1426-3b15-471b-9e14-45a1b5958b5a	groups	claim.name
9d5f1426-3b15-471b-9e14-45a1b5958b5a	String	jsonType.label
af29a342-e1fc-4275-bf30-b688bfca3566	true	introspection.token.claim
af29a342-e1fc-4275-bf30-b688bfca3566	true	id.token.claim
af29a342-e1fc-4275-bf30-b688bfca3566	true	access.token.claim
7018006e-d4fd-4de0-b53b-5afe0ae5796e	true	introspection.token.claim
7018006e-d4fd-4de0-b53b-5afe0ae5796e	true	access.token.claim
79b17f36-2a3a-4da5-a2a6-79cb2c634971	AUTH_TIME	user.session.note
79b17f36-2a3a-4da5-a2a6-79cb2c634971	true	introspection.token.claim
79b17f36-2a3a-4da5-a2a6-79cb2c634971	true	id.token.claim
79b17f36-2a3a-4da5-a2a6-79cb2c634971	true	access.token.claim
79b17f36-2a3a-4da5-a2a6-79cb2c634971	auth_time	claim.name
79b17f36-2a3a-4da5-a2a6-79cb2c634971	long	jsonType.label
2858f5db-bd4b-451f-81f7-9d45ae02c839	client_id	user.session.note
2858f5db-bd4b-451f-81f7-9d45ae02c839	true	introspection.token.claim
2858f5db-bd4b-451f-81f7-9d45ae02c839	true	id.token.claim
2858f5db-bd4b-451f-81f7-9d45ae02c839	true	access.token.claim
2858f5db-bd4b-451f-81f7-9d45ae02c839	client_id	claim.name
2858f5db-bd4b-451f-81f7-9d45ae02c839	String	jsonType.label
c657e44f-453b-407b-8605-71863cb1ec7b	clientHost	user.session.note
c657e44f-453b-407b-8605-71863cb1ec7b	true	introspection.token.claim
c657e44f-453b-407b-8605-71863cb1ec7b	true	id.token.claim
c657e44f-453b-407b-8605-71863cb1ec7b	true	access.token.claim
c657e44f-453b-407b-8605-71863cb1ec7b	clientHost	claim.name
c657e44f-453b-407b-8605-71863cb1ec7b	String	jsonType.label
cf37053f-79de-4d65-adea-fdeeedfab18b	clientAddress	user.session.note
cf37053f-79de-4d65-adea-fdeeedfab18b	true	introspection.token.claim
cf37053f-79de-4d65-adea-fdeeedfab18b	true	id.token.claim
cf37053f-79de-4d65-adea-fdeeedfab18b	true	access.token.claim
cf37053f-79de-4d65-adea-fdeeedfab18b	clientAddress	claim.name
cf37053f-79de-4d65-adea-fdeeedfab18b	String	jsonType.label
10d4588b-9936-408c-8b4e-f7b63d622e9e	true	introspection.token.claim
10d4588b-9936-408c-8b4e-f7b63d622e9e	true	multivalued
10d4588b-9936-408c-8b4e-f7b63d622e9e	true	id.token.claim
10d4588b-9936-408c-8b4e-f7b63d622e9e	true	access.token.claim
10d4588b-9936-408c-8b4e-f7b63d622e9e	organization	claim.name
10d4588b-9936-408c-8b4e-f7b63d622e9e	String	jsonType.label
8be2497d-5a4b-4af9-9365-d404b365b509	false	single
8be2497d-5a4b-4af9-9365-d404b365b509	Basic	attribute.nameformat
8be2497d-5a4b-4af9-9365-d404b365b509	Role	attribute.name
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	true	introspection.token.claim
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	true	userinfo.token.claim
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	profile	user.attribute
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	true	id.token.claim
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	true	access.token.claim
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	profile	claim.name
0e5c8ad0-c238-48cb-a506-c88cc40a7d3c	String	jsonType.label
267438e9-f430-4079-acb3-d3d5d2701522	true	introspection.token.claim
267438e9-f430-4079-acb3-d3d5d2701522	true	userinfo.token.claim
267438e9-f430-4079-acb3-d3d5d2701522	updatedAt	user.attribute
267438e9-f430-4079-acb3-d3d5d2701522	true	id.token.claim
267438e9-f430-4079-acb3-d3d5d2701522	true	access.token.claim
267438e9-f430-4079-acb3-d3d5d2701522	updated_at	claim.name
267438e9-f430-4079-acb3-d3d5d2701522	long	jsonType.label
2f3e15f0-495d-4711-b0dc-806e9ca1e592	true	introspection.token.claim
2f3e15f0-495d-4711-b0dc-806e9ca1e592	true	userinfo.token.claim
2f3e15f0-495d-4711-b0dc-806e9ca1e592	zoneinfo	user.attribute
2f3e15f0-495d-4711-b0dc-806e9ca1e592	true	id.token.claim
2f3e15f0-495d-4711-b0dc-806e9ca1e592	true	access.token.claim
2f3e15f0-495d-4711-b0dc-806e9ca1e592	zoneinfo	claim.name
2f3e15f0-495d-4711-b0dc-806e9ca1e592	String	jsonType.label
43ab87f9-4118-4de6-9c0f-0eb1f8532451	true	introspection.token.claim
43ab87f9-4118-4de6-9c0f-0eb1f8532451	true	userinfo.token.claim
43ab87f9-4118-4de6-9c0f-0eb1f8532451	website	user.attribute
43ab87f9-4118-4de6-9c0f-0eb1f8532451	true	id.token.claim
43ab87f9-4118-4de6-9c0f-0eb1f8532451	true	access.token.claim
43ab87f9-4118-4de6-9c0f-0eb1f8532451	website	claim.name
43ab87f9-4118-4de6-9c0f-0eb1f8532451	String	jsonType.label
4a162de3-c585-442b-ae11-7f35fbd73f5b	true	introspection.token.claim
4a162de3-c585-442b-ae11-7f35fbd73f5b	true	userinfo.token.claim
4a162de3-c585-442b-ae11-7f35fbd73f5b	firstName	user.attribute
4a162de3-c585-442b-ae11-7f35fbd73f5b	true	id.token.claim
4a162de3-c585-442b-ae11-7f35fbd73f5b	true	access.token.claim
4a162de3-c585-442b-ae11-7f35fbd73f5b	given_name	claim.name
4a162de3-c585-442b-ae11-7f35fbd73f5b	String	jsonType.label
57af15c5-857a-41df-87ca-51b5d318aeef	true	introspection.token.claim
57af15c5-857a-41df-87ca-51b5d318aeef	true	userinfo.token.claim
57af15c5-857a-41df-87ca-51b5d318aeef	middleName	user.attribute
57af15c5-857a-41df-87ca-51b5d318aeef	true	id.token.claim
57af15c5-857a-41df-87ca-51b5d318aeef	true	access.token.claim
57af15c5-857a-41df-87ca-51b5d318aeef	middle_name	claim.name
57af15c5-857a-41df-87ca-51b5d318aeef	String	jsonType.label
67356456-6133-4303-9522-6cd0f542338a	true	introspection.token.claim
67356456-6133-4303-9522-6cd0f542338a	true	userinfo.token.claim
67356456-6133-4303-9522-6cd0f542338a	nickname	user.attribute
67356456-6133-4303-9522-6cd0f542338a	true	id.token.claim
67356456-6133-4303-9522-6cd0f542338a	true	access.token.claim
67356456-6133-4303-9522-6cd0f542338a	nickname	claim.name
67356456-6133-4303-9522-6cd0f542338a	String	jsonType.label
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	true	introspection.token.claim
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	true	userinfo.token.claim
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	lastName	user.attribute
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	true	id.token.claim
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	true	access.token.claim
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	family_name	claim.name
684ae8fd-7d9f-4f06-ae55-7d7eb4dfcdb0	String	jsonType.label
711648de-2179-4808-ad67-75e22ae1497b	true	introspection.token.claim
711648de-2179-4808-ad67-75e22ae1497b	true	userinfo.token.claim
711648de-2179-4808-ad67-75e22ae1497b	locale	user.attribute
711648de-2179-4808-ad67-75e22ae1497b	true	id.token.claim
711648de-2179-4808-ad67-75e22ae1497b	true	access.token.claim
711648de-2179-4808-ad67-75e22ae1497b	locale	claim.name
711648de-2179-4808-ad67-75e22ae1497b	String	jsonType.label
7fd6b066-1256-41b5-b19b-5c08effdb518	true	introspection.token.claim
7fd6b066-1256-41b5-b19b-5c08effdb518	true	userinfo.token.claim
7fd6b066-1256-41b5-b19b-5c08effdb518	birthdate	user.attribute
7fd6b066-1256-41b5-b19b-5c08effdb518	true	id.token.claim
7fd6b066-1256-41b5-b19b-5c08effdb518	true	access.token.claim
7fd6b066-1256-41b5-b19b-5c08effdb518	birthdate	claim.name
7fd6b066-1256-41b5-b19b-5c08effdb518	String	jsonType.label
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	true	introspection.token.claim
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	true	userinfo.token.claim
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	gender	user.attribute
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	true	id.token.claim
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	true	access.token.claim
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	gender	claim.name
84f04f05-aaf4-4dcc-9a38-10cf3cb295f1	String	jsonType.label
886b6adb-7c19-4b9c-8e86-848f92451022	true	introspection.token.claim
886b6adb-7c19-4b9c-8e86-848f92451022	true	userinfo.token.claim
886b6adb-7c19-4b9c-8e86-848f92451022	username	user.attribute
886b6adb-7c19-4b9c-8e86-848f92451022	true	id.token.claim
886b6adb-7c19-4b9c-8e86-848f92451022	true	access.token.claim
886b6adb-7c19-4b9c-8e86-848f92451022	preferred_username	claim.name
886b6adb-7c19-4b9c-8e86-848f92451022	String	jsonType.label
a726e2b2-2e3d-47cf-b9ba-5fca79fdbf0d	true	introspection.token.claim
a726e2b2-2e3d-47cf-b9ba-5fca79fdbf0d	true	userinfo.token.claim
a726e2b2-2e3d-47cf-b9ba-5fca79fdbf0d	true	id.token.claim
a726e2b2-2e3d-47cf-b9ba-5fca79fdbf0d	true	access.token.claim
b1902104-c643-489c-8c1e-7829da0e42aa	true	introspection.token.claim
b1902104-c643-489c-8c1e-7829da0e42aa	true	userinfo.token.claim
b1902104-c643-489c-8c1e-7829da0e42aa	picture	user.attribute
b1902104-c643-489c-8c1e-7829da0e42aa	true	id.token.claim
b1902104-c643-489c-8c1e-7829da0e42aa	true	access.token.claim
b1902104-c643-489c-8c1e-7829da0e42aa	picture	claim.name
b1902104-c643-489c-8c1e-7829da0e42aa	String	jsonType.label
6e742925-7193-44d5-9e16-1e3de7454e98	true	introspection.token.claim
6e742925-7193-44d5-9e16-1e3de7454e98	true	userinfo.token.claim
6e742925-7193-44d5-9e16-1e3de7454e98	emailVerified	user.attribute
6e742925-7193-44d5-9e16-1e3de7454e98	true	id.token.claim
6e742925-7193-44d5-9e16-1e3de7454e98	true	access.token.claim
6e742925-7193-44d5-9e16-1e3de7454e98	email_verified	claim.name
6e742925-7193-44d5-9e16-1e3de7454e98	boolean	jsonType.label
8288c66d-3436-407e-88a3-a5af0a4a7d5b	true	introspection.token.claim
8288c66d-3436-407e-88a3-a5af0a4a7d5b	true	userinfo.token.claim
8288c66d-3436-407e-88a3-a5af0a4a7d5b	email	user.attribute
8288c66d-3436-407e-88a3-a5af0a4a7d5b	true	id.token.claim
8288c66d-3436-407e-88a3-a5af0a4a7d5b	true	access.token.claim
8288c66d-3436-407e-88a3-a5af0a4a7d5b	email	claim.name
8288c66d-3436-407e-88a3-a5af0a4a7d5b	String	jsonType.label
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	formatted	user.attribute.formatted
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	country	user.attribute.country
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	true	introspection.token.claim
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	postal_code	user.attribute.postal_code
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	true	userinfo.token.claim
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	street	user.attribute.street
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	true	id.token.claim
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	region	user.attribute.region
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	true	access.token.claim
a82082ac-d4b4-4b83-8104-68fdb9eb4d89	locality	user.attribute.locality
355b02e8-b127-4132-8ba6-624ad5dd87d7	true	introspection.token.claim
355b02e8-b127-4132-8ba6-624ad5dd87d7	true	userinfo.token.claim
355b02e8-b127-4132-8ba6-624ad5dd87d7	phoneNumber	user.attribute
355b02e8-b127-4132-8ba6-624ad5dd87d7	true	id.token.claim
355b02e8-b127-4132-8ba6-624ad5dd87d7	true	access.token.claim
355b02e8-b127-4132-8ba6-624ad5dd87d7	phone_number	claim.name
355b02e8-b127-4132-8ba6-624ad5dd87d7	String	jsonType.label
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	true	introspection.token.claim
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	true	userinfo.token.claim
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	phoneNumberVerified	user.attribute
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	true	id.token.claim
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	true	access.token.claim
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	phone_number_verified	claim.name
d98644ff-46fb-4178-a2d0-97fa0c16a6eb	boolean	jsonType.label
34184151-93e5-46b8-9b67-68d3c527b7f5	true	introspection.token.claim
34184151-93e5-46b8-9b67-68d3c527b7f5	true	multivalued
34184151-93e5-46b8-9b67-68d3c527b7f5	foo	user.attribute
34184151-93e5-46b8-9b67-68d3c527b7f5	true	access.token.claim
34184151-93e5-46b8-9b67-68d3c527b7f5	realm_access.roles	claim.name
34184151-93e5-46b8-9b67-68d3c527b7f5	String	jsonType.label
7e2bf72e-7428-4f18-bf0f-0a135cbcdfb8	true	introspection.token.claim
7e2bf72e-7428-4f18-bf0f-0a135cbcdfb8	true	multivalued
7e2bf72e-7428-4f18-bf0f-0a135cbcdfb8	foo	user.attribute
7e2bf72e-7428-4f18-bf0f-0a135cbcdfb8	true	access.token.claim
7e2bf72e-7428-4f18-bf0f-0a135cbcdfb8	resource_access.${client_id}.roles	claim.name
7e2bf72e-7428-4f18-bf0f-0a135cbcdfb8	String	jsonType.label
861caa38-4df0-4661-afc7-5e9b2915ebf3	true	introspection.token.claim
861caa38-4df0-4661-afc7-5e9b2915ebf3	true	access.token.claim
c1276f01-de4c-4bf4-9359-95c9e0457ea3	true	introspection.token.claim
c1276f01-de4c-4bf4-9359-95c9e0457ea3	true	access.token.claim
788a22fa-68c4-48d1-98a6-2cc0130a9154	true	introspection.token.claim
788a22fa-68c4-48d1-98a6-2cc0130a9154	true	multivalued
788a22fa-68c4-48d1-98a6-2cc0130a9154	foo	user.attribute
788a22fa-68c4-48d1-98a6-2cc0130a9154	true	id.token.claim
788a22fa-68c4-48d1-98a6-2cc0130a9154	true	access.token.claim
788a22fa-68c4-48d1-98a6-2cc0130a9154	groups	claim.name
788a22fa-68c4-48d1-98a6-2cc0130a9154	String	jsonType.label
f9908f03-12d1-4695-9382-c6c0e5260ecc	true	introspection.token.claim
f9908f03-12d1-4695-9382-c6c0e5260ecc	true	userinfo.token.claim
f9908f03-12d1-4695-9382-c6c0e5260ecc	username	user.attribute
f9908f03-12d1-4695-9382-c6c0e5260ecc	true	id.token.claim
f9908f03-12d1-4695-9382-c6c0e5260ecc	true	access.token.claim
f9908f03-12d1-4695-9382-c6c0e5260ecc	upn	claim.name
f9908f03-12d1-4695-9382-c6c0e5260ecc	String	jsonType.label
d881491d-32c3-4b10-a5de-15c8b932d6a8	true	introspection.token.claim
d881491d-32c3-4b10-a5de-15c8b932d6a8	true	id.token.claim
d881491d-32c3-4b10-a5de-15c8b932d6a8	true	access.token.claim
3d01604d-1dc3-42ff-bc1d-d221e06e80a9	AUTH_TIME	user.session.note
3d01604d-1dc3-42ff-bc1d-d221e06e80a9	true	introspection.token.claim
3d01604d-1dc3-42ff-bc1d-d221e06e80a9	true	id.token.claim
3d01604d-1dc3-42ff-bc1d-d221e06e80a9	true	access.token.claim
3d01604d-1dc3-42ff-bc1d-d221e06e80a9	auth_time	claim.name
3d01604d-1dc3-42ff-bc1d-d221e06e80a9	long	jsonType.label
432c2798-857a-499c-93a5-f5d64ece18fb	true	introspection.token.claim
432c2798-857a-499c-93a5-f5d64ece18fb	true	access.token.claim
5f2e6ca1-273a-4650-927d-8e37f338c993	clientHost	user.session.note
5f2e6ca1-273a-4650-927d-8e37f338c993	true	introspection.token.claim
5f2e6ca1-273a-4650-927d-8e37f338c993	true	id.token.claim
5f2e6ca1-273a-4650-927d-8e37f338c993	true	access.token.claim
5f2e6ca1-273a-4650-927d-8e37f338c993	clientHost	claim.name
5f2e6ca1-273a-4650-927d-8e37f338c993	String	jsonType.label
692d09ab-6d48-46b6-8d76-df7329b6d106	clientAddress	user.session.note
692d09ab-6d48-46b6-8d76-df7329b6d106	true	introspection.token.claim
692d09ab-6d48-46b6-8d76-df7329b6d106	true	id.token.claim
692d09ab-6d48-46b6-8d76-df7329b6d106	true	access.token.claim
692d09ab-6d48-46b6-8d76-df7329b6d106	clientAddress	claim.name
692d09ab-6d48-46b6-8d76-df7329b6d106	String	jsonType.label
f14500b3-256d-4013-a504-b459cd094db4	client_id	user.session.note
f14500b3-256d-4013-a504-b459cd094db4	true	introspection.token.claim
f14500b3-256d-4013-a504-b459cd094db4	true	id.token.claim
f14500b3-256d-4013-a504-b459cd094db4	true	access.token.claim
f14500b3-256d-4013-a504-b459cd094db4	client_id	claim.name
f14500b3-256d-4013-a504-b459cd094db4	String	jsonType.label
cab208dd-4bab-4f5b-8710-1ce68ffaf2f0	true	introspection.token.claim
cab208dd-4bab-4f5b-8710-1ce68ffaf2f0	true	multivalued
cab208dd-4bab-4f5b-8710-1ce68ffaf2f0	true	id.token.claim
cab208dd-4bab-4f5b-8710-1ce68ffaf2f0	true	access.token.claim
cab208dd-4bab-4f5b-8710-1ce68ffaf2f0	organization	claim.name
cab208dd-4bab-4f5b-8710-1ce68ffaf2f0	String	jsonType.label
a3733b3c-3223-43c1-869c-db95052a6cfc	true	introspection.token.claim
a3733b3c-3223-43c1-869c-db95052a6cfc	true	userinfo.token.claim
a3733b3c-3223-43c1-869c-db95052a6cfc	locale	user.attribute
a3733b3c-3223-43c1-869c-db95052a6cfc	true	id.token.claim
a3733b3c-3223-43c1-869c-db95052a6cfc	true	access.token.claim
a3733b3c-3223-43c1-869c-db95052a6cfc	locale	claim.name
a3733b3c-3223-43c1-869c-db95052a6cfc	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
5000cf22-fc94-4d79-8942-f7e575263547	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	4a84d94c-77b7-46a2-baff-eecd72ed7d76	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	5114eaf6-20f1-488e-bddb-5d1705482083	eb3669ec-0dcd-4626-94cc-4f05eeb78b88	58f043c9-662d-4d91-939a-0a1f9573af25	2453e655-9434-40ad-9cda-8cd6e566f858	edb809e4-e720-437f-be71-4153caa3306e	2592000	f	900	t	f	bf7cbaf8-a205-4991-9be8-dbae7e397b03	0	f	0	0	84d40434-6659-4c99-950b-f8348db6c316
64ff6a29-5a1a-4538-bfe4-ab59163e838a	60	300	300	\N	\N	\N	t	f	0	\N	ahmed	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	b1de8f1f-c35d-4e3e-8eeb-0bf038a2ff58	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	8591a9b7-ffca-4e63-9517-8155111430e2	99aa369c-2732-41ec-8035-79eebd58de94	ff4b4009-e0ce-4ee6-8202-d579820d66dc	0a2f28e3-5a07-4548-8e59-f10f73408903	1c24cfe9-6ca2-4607-a845-67f091bc46e7	2592000	f	900	t	f	0c09a2bf-9fd8-46cc-8817-d9b5dcd1e17a	0	f	0	0	65fd8bcd-250a-4a80-a33f-2b497aafc5b5
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	5000cf22-fc94-4d79-8942-f7e575263547	
_browser_header.xContentTypeOptions	5000cf22-fc94-4d79-8942-f7e575263547	nosniff
_browser_header.referrerPolicy	5000cf22-fc94-4d79-8942-f7e575263547	no-referrer
_browser_header.xRobotsTag	5000cf22-fc94-4d79-8942-f7e575263547	none
_browser_header.xFrameOptions	5000cf22-fc94-4d79-8942-f7e575263547	SAMEORIGIN
_browser_header.contentSecurityPolicy	5000cf22-fc94-4d79-8942-f7e575263547	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	5000cf22-fc94-4d79-8942-f7e575263547	1; mode=block
_browser_header.strictTransportSecurity	5000cf22-fc94-4d79-8942-f7e575263547	max-age=31536000; includeSubDomains
bruteForceProtected	5000cf22-fc94-4d79-8942-f7e575263547	false
permanentLockout	5000cf22-fc94-4d79-8942-f7e575263547	false
maxTemporaryLockouts	5000cf22-fc94-4d79-8942-f7e575263547	0
bruteForceStrategy	5000cf22-fc94-4d79-8942-f7e575263547	MULTIPLE
maxFailureWaitSeconds	5000cf22-fc94-4d79-8942-f7e575263547	900
minimumQuickLoginWaitSeconds	5000cf22-fc94-4d79-8942-f7e575263547	60
waitIncrementSeconds	5000cf22-fc94-4d79-8942-f7e575263547	60
quickLoginCheckMilliSeconds	5000cf22-fc94-4d79-8942-f7e575263547	1000
maxDeltaTimeSeconds	5000cf22-fc94-4d79-8942-f7e575263547	43200
failureFactor	5000cf22-fc94-4d79-8942-f7e575263547	30
realmReusableOtpCode	5000cf22-fc94-4d79-8942-f7e575263547	false
firstBrokerLoginFlowId	5000cf22-fc94-4d79-8942-f7e575263547	36e8b7cb-3d27-43c3-9405-26ee99b59a01
displayName	5000cf22-fc94-4d79-8942-f7e575263547	Keycloak
displayNameHtml	5000cf22-fc94-4d79-8942-f7e575263547	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	5000cf22-fc94-4d79-8942-f7e575263547	RS256
offlineSessionMaxLifespanEnabled	5000cf22-fc94-4d79-8942-f7e575263547	false
offlineSessionMaxLifespan	5000cf22-fc94-4d79-8942-f7e575263547	5184000
_browser_header.contentSecurityPolicyReportOnly	64ff6a29-5a1a-4538-bfe4-ab59163e838a	
_browser_header.xContentTypeOptions	64ff6a29-5a1a-4538-bfe4-ab59163e838a	nosniff
_browser_header.referrerPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	no-referrer
_browser_header.xRobotsTag	64ff6a29-5a1a-4538-bfe4-ab59163e838a	none
_browser_header.xFrameOptions	64ff6a29-5a1a-4538-bfe4-ab59163e838a	SAMEORIGIN
_browser_header.contentSecurityPolicy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1; mode=block
_browser_header.strictTransportSecurity	64ff6a29-5a1a-4538-bfe4-ab59163e838a	max-age=31536000; includeSubDomains
bruteForceProtected	64ff6a29-5a1a-4538-bfe4-ab59163e838a	false
permanentLockout	64ff6a29-5a1a-4538-bfe4-ab59163e838a	false
maxTemporaryLockouts	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0
bruteForceStrategy	64ff6a29-5a1a-4538-bfe4-ab59163e838a	MULTIPLE
maxFailureWaitSeconds	64ff6a29-5a1a-4538-bfe4-ab59163e838a	900
minimumQuickLoginWaitSeconds	64ff6a29-5a1a-4538-bfe4-ab59163e838a	60
waitIncrementSeconds	64ff6a29-5a1a-4538-bfe4-ab59163e838a	60
quickLoginCheckMilliSeconds	64ff6a29-5a1a-4538-bfe4-ab59163e838a	1000
maxDeltaTimeSeconds	64ff6a29-5a1a-4538-bfe4-ab59163e838a	43200
failureFactor	64ff6a29-5a1a-4538-bfe4-ab59163e838a	30
realmReusableOtpCode	64ff6a29-5a1a-4538-bfe4-ab59163e838a	false
defaultSignatureAlgorithm	64ff6a29-5a1a-4538-bfe4-ab59163e838a	RS256
offlineSessionMaxLifespanEnabled	64ff6a29-5a1a-4538-bfe4-ab59163e838a	false
offlineSessionMaxLifespan	64ff6a29-5a1a-4538-bfe4-ab59163e838a	5184000
actionTokenGeneratedByAdminLifespan	64ff6a29-5a1a-4538-bfe4-ab59163e838a	43200
actionTokenGeneratedByUserLifespan	64ff6a29-5a1a-4538-bfe4-ab59163e838a	300
oauth2DeviceCodeLifespan	64ff6a29-5a1a-4538-bfe4-ab59163e838a	600
oauth2DevicePollingInterval	64ff6a29-5a1a-4538-bfe4-ab59163e838a	5
webAuthnPolicyRpEntityName	64ff6a29-5a1a-4538-bfe4-ab59163e838a	keycloak
webAuthnPolicySignatureAlgorithms	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ES256,RS256
webAuthnPolicyRpId	64ff6a29-5a1a-4538-bfe4-ab59163e838a	
webAuthnPolicyAttestationConveyancePreference	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyAuthenticatorAttachment	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyRequireResidentKey	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyUserVerificationRequirement	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyCreateTimeout	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0
webAuthnPolicyAvoidSameAuthenticatorRegister	64ff6a29-5a1a-4538-bfe4-ab59163e838a	false
webAuthnPolicyRpEntityNamePasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ES256,RS256
webAuthnPolicyRpIdPasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	
webAuthnPolicyAttestationConveyancePreferencePasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyRequireResidentKeyPasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	not specified
webAuthnPolicyCreateTimeoutPasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	false
cibaBackchannelTokenDeliveryMode	64ff6a29-5a1a-4538-bfe4-ab59163e838a	poll
cibaExpiresIn	64ff6a29-5a1a-4538-bfe4-ab59163e838a	120
cibaInterval	64ff6a29-5a1a-4538-bfe4-ab59163e838a	5
cibaAuthRequestedUserHint	64ff6a29-5a1a-4538-bfe4-ab59163e838a	login_hint
parRequestUriLifespan	64ff6a29-5a1a-4538-bfe4-ab59163e838a	60
firstBrokerLoginFlowId	64ff6a29-5a1a-4538-bfe4-ab59163e838a	ec6a7655-27fb-4df5-a478-13236f3ff4bc
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
5000cf22-fc94-4d79-8942-f7e575263547	jboss-logging
64ff6a29-5a1a-4538-bfe4-ab59163e838a	jboss-logging
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
password	password	t	t	5000cf22-fc94-4d79-8942-f7e575263547
password	password	t	t	64ff6a29-5a1a-4538-bfe4-ab59163e838a
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.redirect_uris (client_id, value) FROM stdin;
599987ac-15a6-4633-ad5a-2e8f7cd44d26	/realms/master/account/*
f205166f-d4fb-481e-a5c1-4ee8cffb2906	/realms/master/account/*
7804a2f3-c8ff-4afc-9a61-49837f83353d	/admin/master/console/*
cdd47509-7308-47bf-83cc-bebf9cb8a613	/realms/ahmed/account/*
7863fa10-ba9a-4cdd-aa72-70397455b30e	/realms/ahmed/account/*
92b2e86f-9e39-4e89-9c09-b56a0766785a	/admin/ahmed/console/*
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
9064486f-f82b-477b-833a-585d1826f331	VERIFY_EMAIL	Verify Email	5000cf22-fc94-4d79-8942-f7e575263547	t	f	VERIFY_EMAIL	50
8a3fba38-d763-4e4f-93b6-a6cf5ac62da0	UPDATE_PROFILE	Update Profile	5000cf22-fc94-4d79-8942-f7e575263547	t	f	UPDATE_PROFILE	40
76716795-3705-4b92-99ae-c6feb1125548	CONFIGURE_TOTP	Configure OTP	5000cf22-fc94-4d79-8942-f7e575263547	t	f	CONFIGURE_TOTP	10
651b25b4-6219-44fb-bb31-650d74f2890b	UPDATE_PASSWORD	Update Password	5000cf22-fc94-4d79-8942-f7e575263547	t	f	UPDATE_PASSWORD	30
6e4b4179-ec2d-4469-bcaa-d3d8dfd909e1	TERMS_AND_CONDITIONS	Terms and Conditions	5000cf22-fc94-4d79-8942-f7e575263547	f	f	TERMS_AND_CONDITIONS	20
59ea915d-7747-4726-88a8-fee07919363e	delete_account	Delete Account	5000cf22-fc94-4d79-8942-f7e575263547	f	f	delete_account	60
f75678f5-b5b7-446f-a6d6-a4545ff2d781	delete_credential	Delete Credential	5000cf22-fc94-4d79-8942-f7e575263547	t	f	delete_credential	100
ef41e756-6989-4d82-9300-488ef17f495d	update_user_locale	Update User Locale	5000cf22-fc94-4d79-8942-f7e575263547	t	f	update_user_locale	1000
f09b7447-5205-4764-949c-9e0242191f23	webauthn-register	Webauthn Register	5000cf22-fc94-4d79-8942-f7e575263547	t	f	webauthn-register	70
8554d73d-0a6e-4cee-9a50-80ad402062a3	webauthn-register-passwordless	Webauthn Register Passwordless	5000cf22-fc94-4d79-8942-f7e575263547	t	f	webauthn-register-passwordless	80
e24eda6c-94b8-4587-b08d-d589e7b15995	VERIFY_PROFILE	Verify Profile	5000cf22-fc94-4d79-8942-f7e575263547	t	f	VERIFY_PROFILE	90
dbf77c56-03ab-4af4-b473-ebeaa18d3aa5	VERIFY_EMAIL	Verify Email	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	VERIFY_EMAIL	50
a0677780-5df5-4a5e-9003-0b06db7ea4ca	UPDATE_PROFILE	Update Profile	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	UPDATE_PROFILE	40
bd995fa1-aa19-4943-ae3c-644ff5016e89	CONFIGURE_TOTP	Configure OTP	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	CONFIGURE_TOTP	10
e6ec04f5-13c7-4828-b3bc-3a6f7f4ddf36	UPDATE_PASSWORD	Update Password	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	UPDATE_PASSWORD	30
b0e61a7f-bbd5-450a-8760-4fe0d5dedcd0	TERMS_AND_CONDITIONS	Terms and Conditions	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f	f	TERMS_AND_CONDITIONS	20
e0784332-872c-443d-bfcd-cce6535ab211	delete_account	Delete Account	64ff6a29-5a1a-4538-bfe4-ab59163e838a	f	f	delete_account	60
58f142e9-941d-4c52-b180-f49ef9de1154	delete_credential	Delete Credential	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	delete_credential	100
b7725580-f5a6-40fa-b310-2d02263d29d9	update_user_locale	Update User Locale	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	update_user_locale	1000
11987b1e-a1f7-4598-87e2-2e59b4fb2cfb	webauthn-register	Webauthn Register	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	webauthn-register	70
b67ef425-4390-40c9-adf2-a88e52f6d49b	webauthn-register-passwordless	Webauthn Register Passwordless	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	webauthn-register-passwordless	80
80018903-c4b2-4531-a3b4-63ee7f5a4bb8	VERIFY_PROFILE	Verify Profile	64ff6a29-5a1a-4538-bfe4-ab59163e838a	t	f	VERIFY_PROFILE	90
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
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
f205166f-d4fb-481e-a5c1-4ee8cffb2906	e6115ace-e4c1-4c55-9db0-7b726150645a
f205166f-d4fb-481e-a5c1-4ee8cffb2906	8391294c-19ae-495b-bb35-74b7248ff408
7863fa10-ba9a-4cdd-aa72-70397455b30e	452d2071-40c2-4a42-8e30-9f42d13a3262
7863fa10-ba9a-4cdd-aa72-70397455b30e	a9e97990-aac0-44f3-8c21-d70a2cb578c2
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	5f80f096-64f1-4488-bd03-e2cbf8b13f14	f8285e08-53c4-4aa5-a9c8-e58b8152c5ec	\N	\N	\N
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
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
5f80f096-64f1-4488-bd03-e2cbf8b13f14	\N	281443ca-e74a-4558-b484-b8ccfc79b708	f	t	\N	\N	\N	5000cf22-fc94-4d79-8942-f7e575263547	admin	1741437164396	\N	0
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

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
84d40434-6659-4c99-950b-f8348db6c316	5f80f096-64f1-4488-bd03-e2cbf8b13f14
a3d30c56-893c-4733-9404-14455521e2d2	5f80f096-64f1-4488-bd03-e2cbf8b13f14
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.web_origins (client_id, value) FROM stdin;
7804a2f3-c8ff-4afc-9a61-49837f83353d	+
92b2e86f-9e39-4e89-9c09-b56a0766785a	+
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


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
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


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
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


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
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


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
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


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
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


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
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


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
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


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
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


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
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


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
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


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
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


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
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


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
-- PostgreSQL database dump complete
--

