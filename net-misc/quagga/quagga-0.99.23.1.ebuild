# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/quagga/quagga-0.99.23.1.ebuild,v 1.8 2015/02/13 11:21:02 klausman Exp $

EAPI="5"

CLASSLESS_BGP_PATCH=ht-20040304-classless-bgp.patch

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils eutils flag-o-matic multilib pam readme.gentoo user

DESCRIPTION="A free routing daemon replacing Zebra supporting RIP, OSPF and BGP"
HOMEPAGE="http://quagga.net/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.xz
	bgpclassless? ( http://hasso.linux.ee/stuff/patches/quagga/${CLASSLESS_BGP_PATCH} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ~s390 sparc x86"
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
	sys-apps/gawk
	sys-devel/libtool:2"
RDEPEND="${COMMON_DEPEND}
	sys-apps/iproute2"

PATCHES=( "${FILESDIR}/${PN}-0.99.22.4-ipctl-forwarding.patch" )

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="Sample configuration files can be found in /usr/share/doc/${PF}/samples
You have to create config files in /etc/quagga before
starting one of the daemons.

You can pass additional options to the daemon by setting the EXTRA_OPTS
variable in their respective file in /etc/conf.d"

pkg_setup() {
	enewgroup quagga
	enewuser quagga -1 -1 /var/empty quagga
}

src_prepare() {
	# Classless prefixes for BGP
	# http://hasso.linux.ee/doku.php/english:network:quagga
	use bgpclassless && epatch "${DISTDIR}/${CLASSLESS_BGP_PATCH}"

	autotools-utils_src_prepare
}

src_configure() {
	append-flags -fno-strict-aliasing

	# do not build PDF docs
	export ac_cv_prog_PDFLATEX=no
	export ac_cv_prog_LATEXMK=no

	local myeconfargs=(
		--enable-exampledir=/usr/share/doc/${PF}/samples
		--enable-isisd --enable-isis-topology
		--enable-user=quagga
		--enable-group=quagga
		--enable-vty-group=quagga
		--with-cflags="${CFLAGS}"
		--with-pkg-extra-version="-gentoo"
		--sysconfdir=/etc/quagga
		--localstatedir=/run/quagga
		--disable-static
		--disable-pie
		$(use_enable caps capabilities)
		$(usex snmp '--enable-snmp' '' '' '')
		$(use_enable !elibc_glibc pcreposix)
		$(use_enable tcp-zebra)
		$(use_enable doc)
		$(usex multipath $(use_enable multipath) '' '=0' '')
		$(usex ospfapi '--enable-opaque-lsa --enable-ospf-te --enable-ospfclient' '' '' '')
		$(use_enable readline vtysh)
		$(use_with pam libpam)
		$(use_enable ipv6)
		$(use_enable ipv6 babeld) # babeld does not build properly with USE="-ipv6", bug #446289
		$(use_enable ipv6 ripngd)
		$(use_enable ipv6 ospf6d)
		$(use_enable ipv6 rtadv)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	readme.gentoo_create_doc

	keepdir /etc/quagga
	fowners root:quagga /etc/quagga
	fperms 0770 /etc/quagga

	# install zebra as a file, symlink the rest
	newinitd "${FILESDIR}"/quagga-services.init.3 zebra

	for service in isisd ripd ospfd bgpd $(use ipv6 && echo babeld ospf6d ripngd); do
		dosym zebra /etc/init.d/${service}
	done

	use readline && use pam && newpamd "${FILESDIR}/quagga.pam" quagga

	insinto /etc/logrotate.d
	newins redhat/quagga.logrotate quagga
}
