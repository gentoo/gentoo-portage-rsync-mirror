# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird/firebird-2.0.3.12981.0-r6.ebuild,v 1.6 2012/06/04 06:30:31 zmedico Exp $

inherit flag-o-matic eutils autotools user versionator multilib

MY_P=Firebird-$(replace_version_separator 4 -)

DESCRIPTION="A relational database offering many ANSI SQL-99 features"
HOMEPAGE="http://www.firebirdsql.org/"
SRC_URI="mirror://sourceforge/firebird/${MY_P}.tar.bz2
	 doc? (	ftp://ftpc.inprise.com/pub/interbase/techpubs/ib_b60_doc.zip )"

LICENSE="IDPL Interbase-1.0"
SLOT="0"
KEYWORDS="amd64 -ia64 x86"
IUSE="doc xinetd examples debug"
RESTRICT="userpriv"

RDEPEND="dev-libs/libedit
	dev-libs/icu"
DEPEND="${RDEPEND}
	doc? ( app-arch/unzip )"
RDEPEND="${RDEPEND}
	xinetd? ( virtual/inetd )
	!sys-cluster/ganglia"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup firebird 450
	enewuser firebird 450 /bin/bash /usr/$(get_libdir)/firebird firebird
}

function check_sed() {
	MSG="sed of $3, required $2 lines modified $1"
	einfo "${MSG}"
	[[ $1 -ge $2 ]] || die "${MSG}"
}

src_unpack() {
	if use doc; then
		# Unpack docs
		mkdir "${WORKDIR}/manuals"
		cd "${WORKDIR}/manuals"
		unpack ib_b60_doc.zip
		cd "${WORKDIR}"
	fi

	unpack "${MY_P}.tar.bz2"

	# compile time relative path hacks, ew :(
	mkdir -p "${WORKDIR}/../etc" \
		"${WORKDIR}/usr" \
		"${WORKDIR}/var/log/firebird" \
		"${WORKDIR}/var/run/firebird"
	cd "${WORKDIR}/usr"; ln -s "${S}/gen/firebird/bin"
	cd "${WORKDIR}/../etc"; ln -s "${S}/gen/firebird" firebird

	cd "${S}"

	epatch "${FILESDIR}/${P}-CVE-2008-0387.patch"
	epatch "${FILESDIR}/${P}-CVE-2008-0467.patch"
	epatch "${FILESDIR}/${P}-external-libs.patch"
	epatch "${FILESDIR}/${P}-flags.patch"
	epatch "${FILESDIR}/${P}-make-deps.patch"

	einfo "Split up Firebird via relative path hacks"
	# sed vs patch for portability and addtional location changes
	# based on FIREBIRD=/usr/lib/firebird
	check_sed "$(sed -i -e 's:"aliases.conf":"../../../etc/firebird/aliases.conf":w /dev/stdout' \
		src/jrd/db_alias.cpp | wc -l )" "1" "src/jrd/db_alias.cpp" # 1 line
	check_sed "$(sed -i -e 's:"isc_event1:"../../../var/run/firebird/isc_event1:w /dev/stdout' \
		-e 's:"isc_lock1:"../../../var/run/firebird/isc_lock1:w /dev/stdout' \
		-e 's:"isc_init1:"../../../var/run/firebird/isc_init1:w /dev/stdout' \
		-e 's:"isc_config:"../../../var/run/firebird/isc_config:w /dev/stdout' \
		-e 's:"isc_guard1:"../../../var/run/firebird/isc_guard1:w /dev/stdout' \
		-e 's:"firebird.log":"../../../var/log/firebird/firebird.log":w /dev/stdout' \
		-e 's:"security2.fdb":"../../../etc/firebird/security2.fdb":w /dev/stdout' \
		src/jrd/file_params.h | wc -l)" "14" "src/jrd/file_params.h" # 14 lines
	check_sed "$(sed -i -e 's:"security2.fdb":"../../../etc/firebird/security2.fdb":w /dev/stdout' \
		src/jrd/jrd_pwd.h | wc -l)" "1" "src/jrd/jrd_pwd.h" # 1 line
	check_sed "$(sed -i -e 's:"firebird.conf":"../../../etc/firebird/firebird.conf":w /dev/stdout' \
		src/jrd/os/config_root.h | wc -l)" "1" "src/jrd/os/config_root.h" # 1 line
	check_sed "$(sed -i -e 's:"bin/fb_cache_print":"../../../usr/bin/fb_cache_print":w /dev/stdout' \
		-e 's:"bin/fb_lock_print":"../../../usr/bin/fb_lock_print":w /dev/stdout' \
		-e 's:"bin/fb_cache_manager":"../../../usr/bin/fb_cache_manager":w /dev/stdout' \
		-e 's:"bin/gstat":"../../../usr/bin/gstat":w /dev/stdout' \
		-e 's:"bin/gbak":"../../../usr/bin/gbak":w /dev/stdout' \
		-e 's:"bin/gdef":"../../../usr/bin/gdef":w /dev/stdout' \
		-e 's:"bin/gsec":"../../../usr/bin/gsec":w /dev/stdout' \
		-e 's:"bin/gjrn":"../../../usr/bin/gjrn":w /dev/stdout' \
		-e 's:"bin/gfix":"../../../usr/bin/gfix":w /dev/stdout' \
		src/jrd/svc.cpp | wc -l)" "26" "src/jrd/svc.cpp" # 26 lines
	check_sed "$(sed -i -e 's:"bin/fb_lock_mgr":"../../../usr/bin/fb_lock_mgr":w /dev/stdout' \
		src/lock/lock.cpp | wc -l)" "1" "src/lock/lock.cpp" # 1 line
	check_sed "$(sed -i -e 's:m_Root_Path + "firebird.conf":"../../../etc/firebird/firebird.conf":w /dev/stdout' \
		src/utilities/fbcpl/fbdialog.cpp | wc -l)" "1" "src/utilities/fbcpl/fbdialog.cpp" # 1 line
	check_sed "$(sed -i -e 's:"security2.fdb":"../../../etc/firebird/security2.fdb":w /dev/stdout' \
		src/utilities/gsec/security.epp | wc -l)" "1" "src/utilities/gsec/security.epp" # 1 line
	check_sed "$(sed -i -e 's:"bin/fbserver":"../../../usr/bin/fbserver":w /dev/stdout' \
		src/utilities/guard/guard.cpp | wc -l)" "1" "src/utilities/guard/guard.cpp" # 1 line
	check_sed "$(sed -i -e 's:"bin/fbguard":"../../../usr/bin/fbguard":w /dev/stdout' \
		src/utilities/ibmgr/ibmgr.h | wc -l)" "1" "src/utilities/ibmgr/ibmgr.h" # 1 line
	check_sed "$(sed -i -e 's:$FIREBIRD/firebird.log:/var/log/firebird/firebird.log:w /dev/stdout' \
		src/utilities/ibmgr/srvrmgr.cpp | wc -l)" "1" "src/utilities/ibmgr/srvrmgr.cpp" # 1 line

	# Rename references to isql to fbsql
	check_sed "$(sed -i -e 's:"isql :"fbsql :w /dev/stdout' \
		src/isql/isql.epp | wc -l)" "1" "src/isql/isql.epp" # 1 line
	check_sed "$(sed -i -e 's:isql :fbsql :w /dev/stdout' \
		src/msgs/history.sql | wc -l)" "4" "src/msgs/history.sql" # 4 lines
	check_sed "$(sed -i -e 's:isql :fbsql :w /dev/stdout' \
		-e 's:ISQL :FBSQL :w /dev/stdout' \
		src/msgs/messages.sql | wc -l)" "4" "src/msgs/messages.sql" # 4 lines

	find "${S}" -name \*.sh -print0 | xargs -0 chmod +x
	rm -rf "${S}"/extern/{editline,icu}

	eautoreconf
}

src_compile() {
	filter-flags -fprefetch-loop-arrays
	filter-mfpmath sse

	econf --prefix=/usr/$(get_libdir)/firebird --with-editline \
		$(use_enable !xinetd superserver) \
		$(use_enable debug) \
		${myconf} || die "econf failed"
	emake -j1 || die "error during make"
}

src_install() {
	cd "${S}/gen/firebird"

# Seems to be ignored?
	insinto /usr/share/firebird/bin
	dobin bin/{changeRunUser,restoreRootRunUser,changeDBAPassword}.sh
	rm bin/*.sh || die "Could not remove *sh files"

	einfo "Renaming isql -> fbsql"
	mv bin/isql bin/fbsql

	insinto /usr/bin
	dobin bin/*

	insinto /usr/include
	doins include/*

	insinto /usr/$(get_libdir)
	dolib.so lib/*.so*
	dolib.a lib/*.a*

	insinto /usr/$(get_libdir)/firebird
	doins *.msg

	insinto /usr/$(get_libdir)/firebird/help
	doins help/help.fdb

	insinto /usr/share/firebird/upgrade
	doins "${S}"/src/misc/upgrade/v2/*

	insinto /etc/firebird
	insopts -m0644 -o firebird -g firebird
	doins misc/*
	doins ../install/misc/aliases.conf
	insopts -m0660 -o firebird -g firebird
	doins security2.fdb

	exeinto /usr/$(get_libdir)/firebird/UDF
	doexe UDF/*.so

	exeinto /usr/$(get_libdir)/firebird/intl
	newexe intl/libfbintl.so fbintl.so

	insinto /usr/$(get_libdir)/firebird/intl
	doins ../install/misc/fbintl.conf

	diropts -m 755 -o firebird -g firebird
	dodir /var/log/firebird
	dodir /var/run/firebird
	keepdir /var/log/firebird
	keepdir /var/run/firebird

	# create links for backwards compatibility
	cd "${D}/usr/$(get_libdir)"
	ln -s libfbclient.so libgds.so
	ln -s libfbclient.so libgds.so.0
	ln -s libfbclient.so libfbclient.so.1

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/${PN}.xinetd.2" ${PN} || die "newins xinetd file failed"
	else
		newinitd "${FILESDIR}/${PN}.init.d" ${PN}
		newconfd "${FILESDIR}/${PN}.conf.d.2" ${PN}
		fperms 640 /etc/conf.d/${PN}
	fi
	doenvd "${FILESDIR}/70${PN}"

	# Install docs
	use doc && dodoc "${WORKDIR}"/manuals/*
	use examples && docinto examples
}

pkg_postinst() {
	# Hack to fix ownership/perms
	chown -fR firebird:firebird "${ROOT}/etc/firebird" \
		"${ROOT}/usr/$(get_libdir)/firebird"
	chmod 750 "${ROOT}/etc/firebird"

	elog
	elog "Firebird is no longer installed in /opt. Binaries are in"
	elog "/usr/bin. The core, udfs, etc are in /usr/lib/firebird. Logs"
	elog "are in /var/log/firebird, and lock files in /var/run/firebird"
	elog "The command line tool isql has been renamed to fbsql."
	elog "Please report any problems or issues to bugs.gentoo.org."
	elog
}

pkg_config() {
	# if found /etc/security.gdb from previous install, backup, and restore as
	# /etc/security2.fdb
	if [ -f "${ROOT}/etc/firebird/security.gdb" ] ; then
		# if we have scurity2.fdb already, back it 1st
		if [ -f "${ROOT}/etc/firebird/security2.fdb" ] ; then
			cp "${ROOT}/etc/firebird/security2.fdb" "${ROOT}/etc/firebird/security2.fdb.old"
		fi
		gbak -B "${ROOT}/etc/firebird/security.gdb" "${ROOT}/etc/firebird/security.gbk"
		gbak -R "${ROOT}/etc/firebird/security.gbk" "${ROOT}/etc/firebird/security2.fdb"
		mv "${ROOT}/etc/firebird/security.gdb" "${ROOT}/etc/firebird/security.gdb.old"
		rm "${ROOT}/etc/firebird/security.gbk"

		# make sure they are readable only to firebird
		chown firebird:firebird "${ROOT}/etc/firebird/{security.*,security2.*}"
		chmod 660 "${ROOT}/etc/firebird/{security.*,security2.*}"

		einfo
		einfo "Converted old security.gdb to security2.fdb, security.gdb has been "
		einfo "renamed to security.gdb.old. if you had previous security2.fdb, "
		einfo "it's backed to security2.fdb.old (all under ${ROOT}/etc/firebird)."
		einfo
	fi

	# we need to enable local access to the server
	if [ ! -f "${ROOT}/etc/hosts.equiv" ] ; then
		touch "${ROOT}/etc/hosts.equiv"
		chown root:0 "${ROOT}/etc/hosts.equiv"
		chmod u=rw,go=r "${ROOT}/etc/hosts.equiv"
	fi

	# add 'localhost.localdomain' to the hosts.equiv file...
	if [ grep -q 'localhost.localdomain$' "${ROOT}/etc/hosts.equiv" 2>/dev/null ] ; then
		echo "localhost.localdomain" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added localhost.localdomain to ${ROOT}/etc/hosts.equiv"
	fi

	# add 'localhost' to the hosts.equiv file...
	if [ grep -q 'localhost$' "${ROOT}/etc/hosts.equiv" 2>/dev/null ] ; then
		echo "localhost" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added localhost to ${ROOT}/etc/hosts.equiv"
	fi

	HS_NAME=`hostname`
	if [ grep -q ${HS_NAME} "${ROOT}/etc/hosts.equiv" 2>/dev/null ] ; then
		echo "${HS_NAME}" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added ${HS_NAME} to ${ROOT}/etc/hosts.equiv"
	fi

	einfo "If you're using UDFs, please remember to move them"
	einfo "to /usr/lib/firebird/UDF"
}
