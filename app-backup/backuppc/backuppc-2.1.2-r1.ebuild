# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backuppc/backuppc-2.1.2-r1.ebuild,v 1.6 2013/11/07 02:33:23 patrick Exp $

inherit eutils webapp user

IUSE="samba doc"

MY_P=BackupPC-${PV}
PATCH_VER=0.1
S="${WORKDIR}"/${MY_P}
DESCRIPTION="A high-performance system for backing up computers to a server's disk."
HOMEPAGE="http://backuppc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://gentoo/${P}-gentoo-${PATCH_VER}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"

DEPEND="dev-lang/perl"
RDEPEND="dev-perl/File-RsyncP
	app-arch/par2cmdline
	app-arch/gzip
	app-arch/bzip2
	app-arch/unzip
	dev-perl/Archive-Zip
	virtual/mta
	samba? ( net-fs/samba )"

PATCHDIR="${WORKDIR}"/gentoo/prepatch

pkg_setup() {
	enewgroup backuppc
	enewuser backuppc -1 -1 /dev/null backuppc

	webapp_pkg_setup
}

src_unpack() {
	unpack ${A}; cd "${S}"
	epatch "${FILESDIR}"/${MY_P}pl2.diff

	EPATCH_SUFFIX="diff" epatch "${PATCHDIR}"
}

src_compile() {
	find ./ -name 'CVS' -type d | xargs rm -rf
}

src_test() {
	einfo "Can not test"
}

src_install() {
	local myconf
	if use samba ; then
		myconf="--bin-path smbclient=$(type -p smbclient)"
		myconf="--bin-path nmblookup=$(type -p nmblookup)"
	fi

	webapp_src_preinst

	dodir ${MY_HTDOCSDIR}/${PN}

	./configure.pl \
		--batch \
		--bin-path perl=$(type -p perl) \
		--bin-path ptar=$(type -p tar) \
		--bin-path rsync=$(type -p rsync) \
		--bin-path ping=$(type -p ping) \
		--bin-path df=$(type -p df) \
		--bin-path ssh=$(type -p ssh) \
		--bin-path sendmail=$(type -p sendmail) \
		--bin-path hostname=$(type -p hostname) \
		--bin-path gzip=$(type -p gzip) \
		--bin-path bzip2=$(type -p bzip2) \
		--bin-path hostname=$(type -p hostname) \
		--hostname XXXXXX \
		--uid-ignore \
		--install-dir=/usr \
		--dest-dir "${D}" \
		--html-dir ${MY_HTDOCSDIR}/image \
		--html-dir-url /backuppc/image \
		--cgi-dir ${MY_CGIBINDIR}/ \
		--data-dir /var/lib/backuppc \
		${myconf} || die "failed the configure.pl script"

	pod2man \
		--section=8 \
		--center="BackupPC manual" \
		"${S}"/doc/BackupPC.pod backuppc.8 || die "failed to generate man page"

	doman backuppc.8

	diropts -m 750
	keepdir /var/lib/backuppc/{trash,pool,pc,log,cpool}

	diropts -m 755
	dodir /etc/backuppc
	mv "${D}"/var/lib/backuppc/conf/* "${D}"/etc/backuppc
	rmdir "${D}"/var/lib/backuppc/conf

	fperms 644 /etc/backuppc/config.pl
	fperms 644 /etc/backuppc/hosts

	newinitd "${S}"/init.d/gentoo-backuppc backuppc
	newconfd "${S}"/init.d/gentoo-backuppc.conf backuppc

	webapp_postinst_txt \
		en "${FILESDIR}"/postinstall-en.txt || die "webapp_postinst_txt"

	webapp_src_install || die "webapp_src_install"

	cd "${D}"/etc/backuppc
	ebegin "Patching config.pl for sane defaults"
		patch -p0 < "${WORKDIR}"/gentoo/postpatch/config.pl.diff
	eend $?

	chown -R backuppc:backuppc "${D}/var/lib/backuppc"
}

pkg_postinst() {
	webapp_pkg_postinst

	ebegin "Adjusting ownership of /var/lib/backuppc"
	chown -R backuppc:backuppc "${ROOT}/var/lib/backuppc"
	eend $?

	elog "Please read the documentation"
	elog "It is important to know that the webserver and the backuppc user"
	elog "*must* be one and the same"

}
