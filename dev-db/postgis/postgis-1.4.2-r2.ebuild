# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.4.2-r2.ebuild,v 1.1 2013/01/30 14:46:58 titanofold Exp $

EAPI="4"

inherit eutils versionator

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.net"
SRC_URI="http://download.osgeo.org/postgis/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gtk"

RDEPEND="
		|| (
			dev-db/postgresql-server:8.4
			dev-db/postgresql-server:8.3
			dev-db/postgresql-server:8.2
		)
		>=sci-libs/geos-3.1
		>=sci-libs/proj-4.5.0
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
"

RESTRICT="test"

PGIS="$(get_version_component_range 1-2)"

# not parallel safe
MAKEOPTS+=" -j1"

pkg_setup() {
	export PGSLOT="$(postgresql-config show)"

	if [[ ${PGSLOT//.} < 82 || ${PGSLOT//.} > 84 ]] ; then
		eerror "You must build ${CATEGORY}/${P} against PostgreSQL 8.2 - 8.4."
		eerror "Set an appropriate slot with postgresql-config."
		die 'Select a PostgreSQL slot between 8.2 and 8.4'
	fi
}

src_configure() {
	# Configure interprets --without-gui as being the same as --with-gui
	local myargs=""
	use gtk && myargs+=" --with-gui"
	econf \
		${myargs}
}

src_compile() {
	# Occasionally, builds fail because of out of order compilation.
	# Otherwise, it'd be fine.
	emake
	cd topology/
	emake

	if use doc ; then
		cd "${S}/doc/"
		emake
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	cd topology/
	emake DESTDIR="${D}" install

	cd "${S}"
	dodoc CREDITS TODO loader/README.* doc/*txt

	docinto topology
	dodoc topology/{TODO,README}
	dobin ./utils/postgis_restore.pl

	if use doc; then
		cd doc/html
		dohtml -r *
	fi

	insinto /usr/share/postgresql-${PGSLOT}/contrib/postgis-${PGIS}/
	doins postgis_comments.sql

	insinto /etc
	doins "${FILESDIR}/postgis_dbs-${PGIS}"

	cd "${S}/doc"
	doman man/*
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
	source "${EROOT%/}/etc/postgis_dbs-${PGIS}"
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
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis_comments.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${upgrade_from_1_2[@]} ; do
		ebegin "Upgrading from PostGIS 1.2 to ${PGIS} on ${db}"
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis_upgrade_12_to_${PGIS//.}.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${upgrade_from_1_3[@]} ; do
		ebegin "Upgrading from PostGIS 1.3 to ${PGIS} on ${db}"
		psql -q -U ${pguser} -p ${PGPORT} -d ${db} \
			-f "${postgis_path}/postgis_upgrade_13_to_${PGIS//.}.sql"
		retval=$?
		[[ $retval == 0 ]] && eend 0 || safe_exit
	done

	for db in ${upgrade_from_1_4[@]} ; do
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
