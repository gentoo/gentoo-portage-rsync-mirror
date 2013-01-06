# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.99.21.ebuild,v 1.9 2012/12/22 15:20:38 ago Exp $

EAPI="4"

CLASSLESS_BGP_PATCH=ht-20040304-classless-bgp.patch
#BACKPORTS=2

AUTOTOOLS_AUTORECONF=1
inherit eutils autotools-utils multilib flag-o-matic pam user

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP"
HOMEPAGE="http://quagga.net/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.xz
	${BACKPORTS:+
		http://dev.gentoo.org/~flameeyes/${PN}/${P}-backports-${BACKPORTS}.tar.xz}
	bgpclassless? ( http://hasso.linux.ee/stuff/patches/quagga/${CLASSLESS_BGP_PATCH} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc s390 sparc x86"
IUSE="bgpclassless caps doc elibc_glibc ipv6 multipath ospfapi pam +readline snmp tcp-zebra"

COMMON_DEPEND="
	caps? ( sys-libs/libcap )
	snmp? ( net-analyzer/net-snmp )
	readline? (
		sys-libs/readline
		pam? ( sys-libs/pam )
	)
	!elibc_glibc? ( dev-libs/libpcre )"
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	>=sys-devel/libtool-2.2.4"
RDEPEND="${COMMON_DEPEND}
	sys-apps/openrc
	sys-apps/iproute2"

pkg_setup() {
	enewgroup quagga
	enewuser quagga -1 -1 /var/empty quagga
}

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	# bug #446289
	epatch "${FILESDIR}/${P}-fix-no-ipv6.patch"

	# bug #446346
	epatch "${FILESDIR}/${PN}-link-libcap.patch"

	# Classless prefixes for BGP
	# http://hasso.linux.ee/doku.php/english:network:quagga
	use bgpclassless && epatch "${DISTDIR}/${CLASSLESS_BGP_PATCH}"

	autotools-utils_src_prepare
}

src_configure() {
	append-flags -fno-strict-aliasing
	local myeconfargs=(
		--enable-user=quagga
		--enable-group=quagga
		--enable-vty-group=quagga
		--with-cflags="${CFLAGS}"
		--sysconfdir=/etc/quagga
		--enable-exampledir=/usr/share/doc/${PF}/samples
		--localstatedir=/var/run/quagga
		--disable-static
		--disable-pie
		--disable-babeld # does not build properly with USE="-ipv6", bug #446289
		$(use_enable caps capabilities)
		$(use_enable snmp)
		$(use_enable !elibc_glibc pcreposix)
		$(use_enable tcp-zebra)
		$(use_enable doc)
		$(usex multipath $(use_enable multipath) '' '=0' '')
		$(usex ospfapi '--enable-opaque-lsa --enable-ospf-te --enable-ospfclient' '' '' '')
		$(use_enable readline vtysh)
		$(use_with pam libpam)
		$(use_enable ipv6)
		$(use_enable ipv6 ripngd)
		$(use_enable ipv6 ospf6d)
		$(use_enable ipv6 rtadv)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	keepdir /etc/quagga
	fowners root:quagga /etc/quagga
	fperms 0770 /etc/quagga

	# install zebra as a file, symlink the rest
	newinitd "${FILESDIR}"/quagga-services.init.3 zebra

	for service in ripd ospfd bgpd $(use ipv6 && echo ripngd ospf6d); do
		dosym zebra /etc/init.d/${service}
	done

	use readline && newpamd "${FILESDIR}/quagga.pam" quagga

	insinto /etc/logrotate.d
	newins redhat/quagga.logrotate quagga
}

pkg_postinst() {
	elog "Sample configuration files can be found in /usr/share/doc/${PF}/samples"
	elog "You have to create config files in /etc/quagga before"
	elog "starting one of the daemons."
	elog ""
	elog "You can pass additional options to the daemon by setting the EXTRA_OPTS"
	elog "variable in their respective file in /etc/conf.d"
	elog ""
	elog "Starting from version 0.99.18, quagga no longer supports the realms patch."
	elog "The patch was abandoned upstream and once again didn't apply; it needs a"
	elog "dedicated maintainer, if it is still necessary."
}
