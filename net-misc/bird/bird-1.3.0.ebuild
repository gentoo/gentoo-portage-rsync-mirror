# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bird/bird-1.3.0.ebuild,v 1.1 2011/03/31 09:48:53 chainsaw Exp $

EAPI=1

inherit base autotools

DESCRIPTION="A routing daemon implementing OSPF, RIPv2 & BGP for IPv4 or IPv6"
HOMEPAGE="http://bird.network.cz"
SRC_URI="ftp://bird.network.cz/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ipv6"

RDEPEND="sys-libs/ncurses
	sys-libs/readline
	${DEPEND}"
DEPEND="sys-devel/flex
	sys-devel/bison
	sys-devel/m4"

PATCHES=(
	"${FILESDIR}/${PV}-v4-v6-build.patch"
)

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_compile() {
	econf \
		--enable-client \
		--enable-ipv4 \
		--disable-ipv6 \
		--localstatedir=/var \
		$(use_enable debug) \
		|| die "V4 configuration stage failed"
	emake || die "V4 compilation stage failed"
	if use ipv6; then
		emake almost-clean
		econf \
			--enable-client \
			--enable-ipv6 \
			--disable-ipv4 \
			--localstatedir=/var \
			$(use_enable debug) \
			|| die "V6 configuration stage failed"
		emake || die "V6 compilation stage failed"
	fi
}

src_install() {
	if use ipv6; then
		dobin birdc6
		dosbin bird6
		newinitd "${FILESDIR}/initd-v6-${P}" bird6 || die "V6 init script installation failed"
	fi
	dobin birdc
	dosbin bird
	newinitd "${FILESDIR}/initd-v4-${P}" bird || die "V4 init script installation failed"
	dodoc doc/bird.conf.example || die "configuration example installation failed"
}
