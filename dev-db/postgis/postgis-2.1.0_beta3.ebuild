# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-2.1.0_beta3.ebuild,v 1.1 2013/06/26 10:59:19 titanofold Exp $

EAPI="4"

PG_SLOT_MIN="9.0"

inherit autotools eutils versionator

MY_PV=$(replace_version_separator 3 '')
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.net"
SRC_URI="http://download.osgeo.org/postgis/source/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc gtk static-libs"

RDEPEND="
		|| (
			dev-db/postgresql-server:9.3
			dev-db/postgresql-server:9.2
			dev-db/postgresql-server:9.1
			dev-db/postgresql-server:9.0
		)
		dev-libs/json-c
		dev-libs/libxml2:2
		>=sci-libs/geos-3.3.8
		>=sci-libs/proj-4.6.0
		>=sci-libs/gdal-1.10.0
		gtk? ( x11-libs/gtk+:2 )
"

DEPEND="${RDEPEND}
		doc? (
				app-text/docbook-xsl-stylesheets
				app-text/docbook-xml-dtd:4.3
				dev-libs/libxslt
				|| (
					media-gfx/imagemagick[png]
					media-gfx/graphicsmagick[imagemagick,png]
				)
		)
		virtual/pkgconfig
"

PGIS="$(get_version_component_range 1-2)"

RESTRICT="test"

# These modules are built using the same *FLAGS that were used to build
# dev-db/postgresql. The right thing to do is to ignore the current
# *FLAGS settings.
QA_FLAGS_IGNORED="usr/lib(64)?/(rt)?postgis-${PGIS}\.so"

# Because developers have been fooled into thinking recursive make is a
# good thing.
MAKEOPTS="-j1"

postgres_check_slot() {
	local pg_slot="$(postgresql-config show) 2> /dev/null"

	# If app-admin/eselect-postgresql is not installed, or the slot
	# hasn't been set before pkg_pretend is called, skip the rest of
	# this function.
	if [[ -z ${pg_slot} || "${pg_slot}" = "(none)" ]] ; then
		if [[ "$EBUILD_PHASE" = "pretend" ]] ; then
			return 1
		else
			if [[ "${pg_slot}" = "(none)" ]] ; then
				die "Please set a default slot with postgresql-config"
			elif [[ -z ${pg_slot} ]] ; then
				die "This isn't supposed to happen."
			fi
		fi
	fi

	if [[ -n $PG_SLOT_MIN && $PG_SLOT_MIN != -1 ]] ; then
		if [[ ${pg_slot//.} < ${PG_SLOT_MIN//.} ]] ; then
			eerror "You must build ${CATEGORY}/${PN} against PostgreSQL ${PG_SLOT_MIN} or higher."
			eerror "Set an appropriate slot with postgresql-config."
			die
		fi
	fi

	if [[ -n $PG_SLOT_MAX && $PG_SLOT_MAX != -1 ]] ; then
		if [[ ${pg_slot//.} > ${PG_SLOT_MAX//.} ]] ; then
			eerror "You must build ${CATEGORY}/${PN} against PostgreSQL ${PG_SLOT_MAX} or lower."
			eerror "Set an appropriate slot with postgresql-config."
		fi
	fi

	if [[ -n $PG_SLOT_SOFT_MAX ]] ; then
		if [[ ${pg_slot//.} > ${PG_SLOT_SOFT_MAX//.} ]] ; then
			ewarn "You are building ${CATEGORY}/${PN} against a version of PostgreSQL greater than ${PG_SLOT_SOFT_MAX}."
			ewarn "This is not supported here."
			ewarn "Any bugs you encounter should be reported upstream."
		fi
	fi
}

pkg_pretend() {
	postgres_check_slot
}
pkg_setup() {
	postgres_check_slot
	export PGSLOT="$(postgresql-config show)"
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0-ldflags.patch" \
		"${FILESDIR}/${PN}-2.0-arflags.patch" \
		"${FILESDIR}/${PN}-2.1-pkgconfig-json.patch"

	local AT_M4DIR="macros"
	eautoreconf
}

src_configure() {
	local myargs=""
	use gtk && myargs+=" --with-gui"
	econf ${myargs}
}

src_compile() {
	# Occasionally, builds fail because of out of order compilation.
	# Otherwise, it'd be fine.
	emake
	emake -C topology

	if use doc ; then
		emake comments
		emake cheatsheets
		emake -C doc html
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	use doc && emake DESTDIR="${D}" comments-install
	emake -C topology DESTDIR="${D}" install
	dobin ./utils/postgis_restore.pl

	dodoc CREDITS TODO loader/README.* doc/*txt

	use doc && dohtml -r doc/html/*

	docinto topology
	dodoc topology/{TODO,README}

	insinto /etc
	doins "${FILESDIR}/postgis_dbs"
}

pkg_postinst() {
	postgresql-config update

	elog "To finish installing or updating PostGIS edit:"
	elog "    ${EROOT%/}/etc/postgis_dbs"
	elog
	elog "Then, run:"
	elog "    emerge --config =${CATEGORY}/${PF}"
}

pkg_config(){
	source "${EROOT%/}/etc/conf.d/postgresql-${PGSLOT}"
	source "${EROOT%/}/etc/postgis_dbs"
	local postgis_path="${EROOT%/}/usr/share/postgresql-${PGSLOT}/contrib/postgis-${PGIS}"

	if [[ -n ${configured} ]] ; then
		einfon "Password for PostgreSQL user '${pguser}': "
		read -s PGPASSWORD
		export PGPASSWORD
		echo
	else
		eerror "You must edit:"
		eerror "    ${EROOT%/}/etc/postgis_dbs"
		eerror "Before running 'emerge --config =${CATEGORY}/${PF}'"
		eerror
		die "Edit postgis_dbs"
	fi

	# The server we work with must be the same slot we built against.
	local server_version
	server_version=$(psql -U ${pguser} -d postgres -p ${PGPORT} \
		-Aqwtc 'SELECT version()' 2> /dev/null)
	if [[ $? = 0 ]] ; then
		server_version=$(echo ${server_version} | cut -d " " -f 2 | \
			cut -d "." -f -2 | tr -d .)
		if [[ $server_version != ${PGSLOT//.} ]] ; then
			unset PGPASSWORD
			eerror "Server version must be ${PGSLOT}.x"
			die "Server version isn't ${PGSLOT}.x"
		fi
	else
		unset PGPASSWORD
		eerror "Is the server running?"
		die "Couldn't connect to server."
	fi

	local retval
	safe_exit() {
		unset PGPASSWORD
		sed -e 's/\(configured\)/#\1/' -i "${EROOT%/}/etc/postgis_dbs"
		eend $retval
		eerror "All actions could not be performed."
		eerror "Read above to see what failed."
		eerror "Once you fix the issue, you'll need to edit:"
		eerror "    ${EROOT%/}/etc/postgis_dbs"
		eerror "As some things may have succeeded."
		eerror
		die "All actions could not be performed"
	}

	local db
	for db in ${databases[@]} ; do
		ebegin "Performing CREATE LANGUAGE on ${db}"
		createlang -U ${pguser} -p ${PGPORT} plpgsql ${db}
		retval=$?
		# In this case, only error code 1 is fatal
		[[ $retval == 1 ]] && safe_exit || eend 0

		ebegin "Enabling PostGIS on ${db}"
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${templates[@]} ; do
		ebegin "Creating template database '${db}'"
		createdb -p ${PGPORT} -U ${pguser} -O ${pguser} -T ${from_template} \
			${db} "PostGIS Template"
		retval=$?
		[[ $retval != 0 ]] && safe_exit

		psql -q -U ${pguser} -p ${PGPORT} -c \
			"UPDATE pg_database \
			 SET datistemplate = TRUE, datallowconn = TRUE \
			 WHERE datname = '${db}'"
		retval=$?
		[[ $retval != 0 ]] && safe_exit

		createlang -U ${pguser} -p ${PGPORT} plpgsql ${db}
		retval=$?
		# In this case, only error code 1 is fatal
		[[ $retval == 1 ]] && safe_exit

		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${epsg_databases[@]} ; do
		ebegin "Adding EPSG to ${db}"
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/spatial_ref_sys.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${comment_databases[@]} ; do
		ebegin "Adding comments on ${db}"
		local comment_file
		for comment_file in "${postgis_path}"/*_comments.sql ; do
			psql -q -U ${pguser} -p ${PGPORT} -d ${db} -f "${comment_file}"
			retval=$?
			[[ $retval == 0 ]] && continue || safe_exit
		done
		eend 0
	done

	for db in ${upgrade_from_1_3[@]} ; do
		ebegin "Upgrading from PostGIS 1.3 to ${PGIS} on ${db}"
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis_upgrade_13_to_${PGIS//.}.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${upgrade_from_1_4[@]} ; do
		ebegin "Upgrading from PostGIS 1.4 to ${PGIS} on ${db}"
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis_upgrade_14_to_${PGIS//.}.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${upgrade_from_1_5[@]} ; do
		ebegin "Minor upgrade for PostGIS ${PGIS} on ${db}"
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis_upgrade_${PGIS//.}_minor.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	# Clean up and make it so the user has to edit postgis_dbs again that
	# way this script won't step on any toes due to user error.
	unset PGPASSWORD
	sed -e 's/\(configured\)/#\1/' -i "${EROOT%/}/etc/postgis_dbs"
	einfo "PostgreSQL ${PGSLOT} is now PostGIS enabled."
	einfo
	einfo "To enable other databases, change the default slot:"
	einfo "    postgresql-config set <slot>"
	einfo "Then, emerge this package again:"
	einfo "    emerge -av =${CATEGORY}/${PF}"
}
