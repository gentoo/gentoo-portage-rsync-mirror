# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sbin/freebsd-sbin-7.2.ebuild,v 1.4 2011/04/15 21:47:56 ulm Exp $

EAPI=2

inherit flag-o-matic bsdmk freebsd

DESCRIPTION="FreeBSD sbin utils"
KEYWORDS="~sparc-fbsd ~x86-fbsd"
SLOT="0"

SRC_URI="mirror://gentoo/${SBIN}.tar.bz2
	mirror://gentoo/${CONTRIB}.tar.bz2
	mirror://gentoo/${LIB}.tar.bz2
	mirror://gentoo/${LIBEXEC}.tar.bz2
	mirror://gentoo/${USBIN}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2
	build? ( mirror://gentoo/${SYS}.tar.bz2 )"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*[ipv6?,atm?,netware?]
	=sys-freebsd/freebsd-libexec-${RV}*
	ssl? ( dev-libs/openssl )
	dev-libs/libedit
	sys-libs/readline
	sys-process/vixie-cron
	atm? ( net-analyzer/bsnmp )"
DEPEND="${RDEPEND}
	!build? ( =sys-freebsd/freebsd-sources-${RV}* )
	=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/sbin"

IUSE="atm ipfilter +pf ipv6 build ssl +cxx netware"

pkg_setup() {
	use atm || mymakeopts="${mymakeopts} WITHOUT_ATM= "
	use cxx || mymakeopts="${mymakeopts} WITHOUT_CXX="
	use ipfilter || mymakeopts="${mymakeopts} WITHOUT_IPFILTER= "
	use ipv6 || mymakeopts="${mymakeopts} WITHOUT_INET6= WITHOUT_INET6_SUPPORT="
	use netware || mymakeopts="${mymakeopts} WITHOUT_IPX= WITHOUT_IPX_SUPPORT= WITHOUT_NCP= "
	use pf || mymakeopts="${mymakeopts} WITHOUT_PF= "
	use ssl || mymakeopts="${mymakeopts} WITHOUT_OPENSSL="

	# O3 breaks this, apparently
	replace-flags -O3 -O2
}

REMOVE_SUBDIRS="dhclient pfctl pflogd rcorder"

PATCHES=( "${FILESDIR}/${PN}-setXid.patch"
	"${FILESDIR}/${PN}-7.1-zlib.patch"
	"${FILESDIR}/${PN}-6.2-ldconfig.patch"
	"${FILESDIR}/${PN}-6.1-pr102701.patch" )

src_prepare() {
	use build || ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"
}

src_install() {
	freebsd_src_install
	keepdir /var/log
	# Needed by ldconfig:
	keepdir /var/run

	# Allow users to use ping and other commands
	dodir /bin
	mv "${D}/sbin/ping" "${D}/bin/" || die "mv failed"

	# ext2fs can mount ext3, you just don't get the journalling
	dosym mount_ext2fs sbin/mount_ext3

	# Do we need pccard.conf if we have devd?
	# Maybe ship our own sysctl.conf so things like radvd work out of the box.
	cd "${WORKDIR}/etc/"
	insinto /etc
	doins defaults/pccard.conf minfree sysctl.conf

	# initd script for idmapd
	newinitd "${FILESDIR}/idmapd.initd" idmapd

	# Install a crontab for adjkerntz
	insinto /etc/cron.d
	newins "${FILESDIR}/adjkerntz-crontab" adjkerntz

	# Install the periodic stuff (needs probably to be ported in a more
	# gentooish way)
	cd "${WORKDIR}/etc/periodic"

	doperiodic security \
		security/*.ipfwlimit \
		security/*.ip6fwlimit \
		security/*.ip6fwdenied \
		security/*.ipfwdenied

	use ipfilter && doperiodic security \
		security/*.ipf6denied \
		security/*.ipfdenied
}
