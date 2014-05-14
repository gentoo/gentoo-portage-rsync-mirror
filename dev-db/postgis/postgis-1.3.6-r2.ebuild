# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgis/postgis-1.3.6-r2.ebuild,v 1.2 2014/05/14 17:07:30 tomwij Exp $

EAPI="5"

inherit eutils multilib versionator

DESCRIPTION="Geographic Objects for PostgreSQL"
HOMEPAGE="http://postgis.net"
SRC_URI="http://download.osgeo.org/postgis/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="geos proj doc"

RDEPEND="		|| (
			dev-db/postgresql-server:8.4
			dev-db/postgresql-server:8.3
			dev-db/postgresql-server:8.2
			dev-db/postgresql-server:8.1
			dev-db/postgresql-server:8.0
		)
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-xsl-stylesheets )"

RESTRICT="test"

pkg_setup(){
	export PGSLOT="$(postgresql-config show)"

	if [[ ${PGSLOT//.} < 71 || ${PGSLOT//.} > 84 ]] ; then
		eerror "You must build ${CATEGORY}/${P} against PostgreSQL 7.1 - 8.4."
		eerror "Set an appropriate slot with postgresql-config."
		die 'Select a PostgreSQL slot between 8.4 and 9.2'
	fi

	if [ ! -z "${PGUSER}" ]; then
		eval unset PGUSER
	fi
	if [ ! -z "${PGDATABASE}" ]; then
		eval unset PGDATABASE
	fi
	local tmp
	tmp="$(portageq match / ${CATEGORY}/${PN} | cut -d'.' -f2)"
	if [ "${tmp}" != "$(get_version_component_range 2)" ]; then
		elog "You must soft upgrade your existing postgis enabled databases"
		elog "by adding their names in the ${ROOT}conf.d/postgis_dbs file"
		elog "then using 'emerge --config postgis'."
		require_soft_upgrade="1"
		ebeep 2
	fi
}

src_configure(){
	local myconf
	if use geos; then
		myconf="--with-geos"
	fi

	if use doc; then
		myconf="${myconf} --with-xsl=$(ls "${ROOT}"usr/share/sgml/docbook/* | \
			grep xsl\- | cut -d':' -f1)"
	fi

	econf --enable-autoconf \
		--datadir=/usr/share/postgresql/contrib/ \
		--libdir=/usr/$(get_libdir)/postgresql/ \
		--with-docdir=/usr/share/doc/${PF}/html/ \
		${myconf} \
		$(use_with proj)
}

src_compile(){
	emake

	cd topology/
	emake

	if use doc ; then
		cd "${S}"
		emake docs
	fi
}

src_install(){
	dodir /usr/$(get_libdir)/postgresql /usr/share/postgresql/contrib/
	default
	cd "${S}/topology/"
	default

	cd "${S}"
	dodoc CREDITS TODO loader/README.* doc/*txt

	docinto topology
	dodoc topology/{TODO,README}
	dobin ./utils/postgis_restore.pl

	cd "${S}"
	if use doc; then
		emake DESTDIR="${D}" docs-install || die "emake install docs failed"
	fi

	echo "template_gis" > postgis_dbs
	doconfd postgis_dbs

	if [ ! -z "${require_soft_upgrade}" ]; then
		grep "'C'" -B 4 "${D}"usr/share/postgresql/contrib/lwpostgis.sql | \
			grep -v "'sql'" > \
				"${D}"usr/share/postgresql/contrib/load_before_upgrade.sql
	fi
}

pkg_postinst() {
	elog "To create new (upgrade) spatial databases add their names in the"
	elog "${ROOT}conf.d/postgis_dbs file, then use 'emerge --config postgis'."
}

pkg_config(){
	einfo "Create or upgrade a spatial templates and databases."
	einfo "Please add your databases names into ${ROOT}conf.d/postgis_dbs"
	einfo "(templates name have to be prefixed with 'template')."
	for i in $(cat "${ROOT}etc/conf.d/postgis_dbs"); do
		source "${ROOT}"etc/conf.d/postgresql
		PGDATABASE=${i}
		eval set PGDATABASE=${i}
		myuser="${PGUSER:-postgres}"
		mydb="${PGDATABASE:-template_gis}"
		eval set PGUSER=${myuser}

		is_template=false
		if [ "${mydb:0:8}" == "template" ];then
			is_template=true
			mytype="template database"
		else
			mytype="database"
		fi

		einfo
		einfo "Using the user ${myuser} and the ${mydb} ${mytype}."

		logfile=$(mktemp "${ROOT}tmp/error.log.XXXXXX")
		safe_exit(){
			eerror "Removing created ${mydb} ${mytype}"
			dropdb -q -U "${myuser}" "${mydb}" ||\
				(eerror "${1}"
				die "Removing old db failed, you must do it manually")
			eerror "Please read ${logfile} for more information."
			die "${1}"
		}

	# if there is not a table or a template existing with the same name, create.
		if [ -z "$(psql -U ${myuser} -l | grep "${mydb}")" ]; then
			createdb -q -O ${myuser} -U ${myuser} ${mydb} ||\
				die "Unable to create the ${mydb} ${mytype} as ${myuser}"
			createlang -U ${myuser} plpgsql ${mydb}
			if [ "$?" == 2 ]; then
				safe_exit "Unable to createlang plpgsql ${mydb}."
			fi
			(psql -q -U ${myuser} ${mydb} -f \
				"${ROOT}"usr/share/postgresql/contrib/lwpostgis.sql &&
			psql -q -U ${myuser} ${mydb} -f \
				"${ROOT}"usr/share/postgresql/contrib/spatial_ref_sys.sql) 2>\
					"${logfile}"
			if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
				safe_exit "Unable to load sql files."
			fi
			if ${is_template}; then
				psql -q -U ${myuser} ${mydb} -c \
					"UPDATE pg_database SET datistemplate = TRUE
					WHERE datname = '${mydb}';
			GRANT ALL ON table spatial_ref_sys, geometry_columns TO PUBLIC;" \
				|| die "Unable to create ${mydb}"
			psql -q -U ${myuser} ${mydb} -c \
				"VACUUM FREEZE;" || die "Unable to set VACUUM FREEZE option"
			fi
		else
			if [ -e "${ROOT}"usr/share/postgresql/contrib/load_before_upgrade.sql ];
			then
				einfo "Updating the dynamic library references"
				psql -q -f \
					"${ROOT}"usr/share/postgresql/contrib/load_before_upgrade.sql\
						2> "${logfile}"
				if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
					safe_exit "Unable to update references."
				fi
			fi
			if [ -e "${ROOT}"usr/share/postgresql/contrib/lwpostgis_upgrade.sql ];
			then
				einfo "Running soft upgrade"
				psql -q -U ${myuser} ${mydb} -f \
					"${ROOT}"usr/share/postgresql/contrib/lwpostgis_upgrade.sql 2>\
						"${logfile}"
				if [ "$(grep -c ERROR "${logfile}")" \> 0 ]; then
					safe_exit "Unable to run soft upgrade."
				fi
			fi
		fi
		if ${is_template}; then
			einfo "You can now create a spatial database using :"
			einfo "'createdb -T ${mydb} test'"
		fi
	done
}
