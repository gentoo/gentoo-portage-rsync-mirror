# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-server/postgresql-server-9.3.0.ebuild,v 1.1 2013/09/10 05:52:55 patrick Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} )
WANT_AUTOMAKE="none"

inherit autotools eutils flag-o-matic multilib pam prefix python-single-r1 systemd user versionator

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~ppc-macos ~x86-solaris"

SLOT="$(get_version_component_range 1-2)"

# Comment the following six lines when not a beta or rc.
#MY_PV="${PV//_}"
#MY_FILE_PV="${SLOT}$(get_version_component_range 4)"
#S="${WORKDIR}/postgresql-${MY_PV}"
#SRC_URI="mirror://postgresql/source/v${MY_PV}/postgresql-${MY_PV}.tar.bz2
#		 http://dev.gentoo.org/~titanofold/postgresql-patches-${SLOT}-r1.tbz2
#		 http://dev.gentoo.org/~titanofold/postgresql-initscript-2.5.tbz2"

# Comment the following four lines when a beta or rc.
S="${WORKDIR}/postgresql-${PV}"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-${PV}.tar.bz2
		 http://dev.gentoo.org/~titanofold/postgresql-patches-${SLOT}-r1.tbz2
		 http://dev.gentoo.org/~titanofold/postgresql-initscript-2.5.tbz2"

LICENSE="POSTGRESQL GPL-2"
DESCRIPTION="PostgreSQL server"
HOMEPAGE="http://www.postgresql.org/"

LINGUAS="af cs de en es fa fr hr hu it ko nb pl pt_BR ro ru sk sl sv tr zh_CN zh_TW"
IUSE="kerberos kernel_linux nls pam perl -pg_legacytimestamp python selinux tcl test uuid xml"

for lingua in ${LINGUAS}; do
	IUSE+=" linguas_${lingua}"
done

wanted_languages() {
	local enable_langs

	for lingua in ${LINGUAS} ; do
		use linguas_${lingua} && enable_langs+="${lingua} "
	done

	echo -n ${enable_langs}
}

RDEPEND="~dev-db/postgresql-base-${PV}:${SLOT}[kerberos?,pam?,pg_legacytimestamp=,nls=]
	perl? ( >=dev-lang/perl-5.8 )
	python? ( ${PYTHON_DEPS} )
	selinux? ( sec-policy/selinux-postgresql )
	tcl? ( >=dev-lang/tcl-8 )
	uuid? ( dev-libs/ossp-uuid )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )"
DEPEND="${RDEPEND}
	sys-devel/flex
	xml? ( virtual/pkgconfig )"
#PDEPEND="doc? ( ~dev-db/postgresql-docs-${PV} )"

pkg_setup() {
	enewgroup postgres 70
	enewuser postgres 70 /bin/bash /var/lib/postgresql postgres

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${WORKDIR}/autoconf.patch" \
		"${WORKDIR}/bool.patch" \
		"${WORKDIR}/server.patch" \
		"${WORKDIR}/run-dir.patch"

	eprefixify src/include/pg_config_manual.h

	if use pam ; then
		sed -e "s/\(#define PGSQL_PAM_SERVICE \"postgresql\)/\1-${SLOT}/" \
			-i src/backend/libpq/auth.c \
			|| die 'PGSQL_PAM_SERVICE rename failed.'
	fi

	if use perl ; then
		sed -e "s:\$(DESTDIR)\$(plperl_installdir):\$(plperl_installdir):" \
			-i "${S}/src/pl/plperl/GNUmakefile" || die 'sed plperl failed'
	fi

	if use test ; then
		epatch "${WORKDIR}/regress.patch"
		sed -e "s|@SOCKETDIR@|${T}|g" -i src/test/regress/pg_regress{,_main}.c
	else
		echo "all install:" > "${S}/src/test/regress/GNUmakefile"
	fi

	sed -e "s|@SLOT@|${SLOT}|g" \
		-i "${WORKDIR}"/postgresql.{init,confd,service} || \
		die "SLOT sed failed"

	eautoconf
}

src_configure() {
	case ${CHOST} in
		*-darwin*|*-solaris*)
			use nls && append-libs intl
			;;
	esac

	local PO="${EPREFIX%/}"

	# eval is needed to get along with pg_config quotation of space-rich entities.
	eval econf "$(${PO}/usr/$(get_libdir)/postgresql-${SLOT}/bin/pg_config --configure)" \
		$(use_with perl) \
		$(use_with python) \
		$(use_with tcl) \
		$(use_with xml libxml) \
		$(use_with xml libxslt) \
		$(use_with uuid ossp-uuid) \
		--with-system-tzdata="${PO}/usr/share/zoneinfo" \
		--with-includes="${PO}/usr/include/postgresql-${SLOT}/" \
		--with-libraries="${PO}/usr/$(get_libdir)/postgresql-${SLOT}/$(get_libdir)" \
		"$(use_enable nls nls "$(wanted_languages)")"
}

src_compile() {
	local bd
	for bd in . contrib $(use xml && echo contrib/xml2); do
		PATH="${EROOT%/}/usr/$(get_libdir)/postgresql-${SLOT}/bin:${PATH}" \
			emake -C $bd || die "emake in $bd failed"
	done
}

src_install() {
	local bd
	for bd in . contrib $(use xml && echo contrib/xml2) ; do
		PATH="${EROOT%/}/usr/$(get_libdir)/postgresql-${SLOT}/bin:${PATH}" \
			emake install -C $bd DESTDIR="${D}" || die "emake install in $bd failed"
	done

	# Avoid file collision with -base.
	local l
	for l in lib lib32 lib64 ; do
		rm "${ED}/usr/${l}/postgresql-${SLOT}/${l}/libpgcommon.a"
	done

	dodir /etc/eselect/postgresql/slots/${SLOT}
	echo "postgres_ebuilds=\"\${postgres_ebuilds} ${PF}\"" > \
		"${ED}/etc/eselect/postgresql/slots/${SLOT}/server"

	newconfd "${WORKDIR}/postgresql.confd" postgresql-${SLOT}
	newinitd "${WORKDIR}/postgresql.init" postgresql-${SLOT}

	systemd_newunit "${WORKDIR}"/postgresql.service postgresql-${SLOT}.service
	systemd_newtmpfilesd "${WORKDIR}"/postgresql.tmpfilesd postgresql-${SLOT}.conf

	use pam && pamd_mimic system-auth postgresql-${SLOT} auth account session

	if use prefix ; then
		keepdir /run/postgresql
		fperms 0775 /run/postgresql
	fi
}

pkg_postinst() {
	postgresql-config update

	elog "Gentoo specific documentation:"
	elog "http://www.gentoo.org/doc/en/postgres-howto.xml"
	elog
	elog "Official documentation:"
	elog "http://www.postgresql.org/docs/${SLOT}/static/index.html"
	elog
	elog "The default location of the Unix-domain socket is:"
	elog "    ${EROOT%/}/run/postgresql/"
	elog
	elog "Before initializing the database, you may want to edit PG_INITDB_OPTS"
	elog "so that it contains your preferred locale in:"
	elog "    ${EROOT%/}/etc/conf.d/postgresql-${SLOT}"
	elog
	elog "Then, execute the following command to setup the initial database"
	elog "environment:"
	elog "    emerge --config =${CATEGORY}/${PF}"
}

pkg_prerm() {
	if [[ -z ${REPLACED_BY_VERSION} ]] ; then
		ewarn "Have you dumped and/or migrated the ${SLOT} database cluster?"
		ewarn "\thttp://www.gentoo.org/doc/en/postgres-howto.xml#doc_chap5"

		ebegin "Resuming removal in 10 seconds (Control-C to cancel)"
		sleep 10
		eend 0
	fi
}

pkg_postrm() {
	postgresql-config update
}

pkg_config() {
	[[ -f "${EROOT%/}/etc/conf.d/postgresql-${SLOT}" ]] && source "${EROOT%/}/etc/conf.d/postgresql-${SLOT}"
	[[ -z "${PGDATA}" ]] && PGDATA="${EROOT%/}/etc/postgresql-${SLOT}/"
	[[ -z "${DATA_DIR}" ]] && DATA_DIR="${EROOT%/}/var/lib/postgresql/${SLOT}/data"

	# environment.bz2 may not contain the same locale as the current system
	# locale. Unset and source from the current system locale.
	if [ -f "${EROOT%/}/etc/env.d/02locale" ]; then
		unset LANG
		unset LC_CTYPE
		unset LC_NUMERIC
		unset LC_TIME
		unset LC_COLLATE
		unset LC_MONETARY
		unset LC_MESSAGES
		unset LC_ALL
		source "${EROOT%/}/etc/env.d/02locale"
		[ -n "${LANG}" ] && export LANG
		[ -n "${LC_CTYPE}" ] && export LC_CTYPE
		[ -n "${LC_NUMERIC}" ] && export LC_NUMERIC
		[ -n "${LC_TIME}" ] && export LC_TIME
		[ -n "${LC_COLLATE}" ] && export LC_COLLATE
		[ -n "${LC_MONETARY}" ] && export LC_MONETARY
		[ -n "${LC_MESSAGES}" ] && export LC_MESSAGES
		[ -n "${LC_ALL}" ] && export LC_ALL
	fi

	einfo "You can modify the paths and options passed to initdb by editing:"
	einfo "    ${EROOT%/}/etc/conf.d/postgresql-${SLOT}"
	einfo
	einfo "Information on options that can be passed to initdb are found at:"
	einfo "    http://www.postgresql.org/docs/${SLOT}/static/creating-cluster.html"
	einfo "    http://www.postgresql.org/docs/${SLOT}/static/app-initdb.html"
	einfo
	einfo "PG_INITDB_OPTS is currently set to:"
	if [[ -z "${PG_INITDB_OPTS}" ]] ; then
		einfo "    (none)"
	else
		einfo "    ${PG_INITDB_OPTS}"
	fi
	einfo
	einfo "Configuration files will be installed to:"
	einfo "    ${PGDATA}"
	einfo
	einfo "The database cluster will be created in:"
	einfo "    ${DATA_DIR}"
	einfo
	while [ "$correct" != "true" ] ; do
		einfo "Are you ready to continue? (y/n)"
		read answer
		if [[ $answer =~ ^[Yy]([Ee][Ss])?$ ]] ; then
			correct="true"
		elif [[ $answer =~ ^[Nn]([Oo])?$ ]] ; then
			die "Aborting initialization."
		else
			echo "Answer not recognized"
		fi
	done

	if [ -n "$(ls -A ${DATA_DIR} 2> /dev/null)" ] ; then
		eerror "The given directory, '${DATA_DIR}', is not empty."
		eerror "Modify DATA_DIR to point to an empty directory."
		die "${DATA_DIR} is not empty."
	fi

	[ -z "${PG_MAX_CONNECTIONS}" ] && PG_MAX_CONNECTIONS="128"
	einfo "Checking system parameters..."

	if ! use kernel_linux ; then
		einfo "Skipped."
		einfo "  Tests not supported on this OS (yet)"
	else
		if [ -z ${SKIP_SYSTEM_TESTS} ] ; then
			einfo "Checking whether your system supports at least ${PG_MAX_CONNECTIONS} connections..."

			local SEMMSL=$(sysctl -n kernel.sem | cut -f1)
			local SEMMNS=$(sysctl -n kernel.sem | cut -f2)
			local SEMMNI=$(sysctl -n kernel.sem | cut -f4)
			local SHMMAX=$(sysctl -n kernel.shmmax)

			local SEMMSL_MIN=17
			local SEMMNS_MIN=$(( ( ${PG_MAX_CONNECTIONS}/16 ) * 17 ))
			local SEMMNI_MIN=$(( ( ${PG_MAX_CONNECTIONS}+15 ) / 16 ))
			local SHMMAX_MIN=$(( 500000 + ( 30600 * ${PG_MAX_CONNECTIONS} ) ))

			for p in SEMMSL SEMMNS SEMMNI SHMMAX ; do
				if [ $(eval echo \$$p) -lt $(eval echo \$${p}_MIN) ] ; then
					eerror "The value for ${p} $(eval echo \$$p) is below the recommended value $(eval echo \$${p}_MIN)"
					eerror "You have now several options:"
					eerror "    - Change the mentioned system parameter"
					eerror "    - Lower the number of max.connections by setting PG_MAX_CONNECTIONS to a"
					eerror "      value lower than ${PG_MAX_CONNECTIONS}"
					eerror "    - Set SKIP_SYSTEM_TESTS in case you want to ignore this test completely"
					eerror "More information can be found here:"
					eerror "    http://www.postgresql.org/docs/${SLOT}/static/kernel-resources.html"
					die "System test failed."
				fi
			done
			einfo "Passed."
		else
			ewarn "SKIP_SYSTEM_TESTS set, so skipping."
		fi
	fi

	einfo "Creating the data directory ..."
	if [[ ${EUID} == 0 ]] ; then
		mkdir -p "${DATA_DIR}"
		chown -Rf postgres:postgres "${DATA_DIR}"
		chmod 0700 "${DATA_DIR}"
	fi

	einfo "Initializing the database ..."

	if [[ ${EUID} == 0 ]] ; then
		su postgres -c "${EROOT%/}/usr/$(get_libdir)/postgresql-${SLOT}/bin/initdb -D \"${DATA_DIR}\" ${PG_INITDB_OPTS}"
	else
		"${EROOT%/}"/usr/$(get_libdir)/postgresql-${SLOT}/bin/initdb -U postgres -D "${DATA_DIR}" ${PG_INITDB_OPTS}
	fi

	mv "${DATA_DIR%/}"/*.conf "${PGDATA}"

	einfo "The autovacuum function, which was in contrib, has been moved to the main"
	einfo "PostgreSQL functions starting with 8.1, and starting with 8.4 is now enabled"
	einfo "by default. You can disable it in the cluster's:"
	einfo "    ${PGDATA%/}/postgresql.conf"
	einfo
	einfo "The PostgreSQL server, by default, will log events to:"
	einfo "    ${DATA_DIR%/}/postmaster.log"
	einfo
	if use prefix ; then
		einfo "The location of the configuration files have moved to:"
		einfo "    ${PGDATA}"
		einfo "To start the server:"
		einfo "    pg_ctl start -D ${DATA_DIR} -o '-D ${PGDATA} --data-directory=${DATA_DIR}'"
		einfo "To stop:"
		einfo "    pg_ctl stop -D ${DATA_DIR}"
		einfo
		einfo "Or move the configuration files back:"
		einfo "mv ${PGDATA}*.conf ${DATA_DIR}"
	else
		einfo "You should use the '${EROOT%/}/etc/init.d/postgresql-${SLOT}' script to run PostgreSQL"
		einfo "instead of 'pg_ctl'."
	fi
}

src_test() {
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"

	if [ ${UID} -ne 0 ] ; then
		emake check

		einfo "If you think other tests besides the regression tests are necessary, please"
		einfo "submit a bug including a patch for this ebuild to enable them."
	else
		ewarn "Tests cannot be run as root. Skipping."
		ewarn "HINT: FEATURES=\"userpriv\""
	fi
}
