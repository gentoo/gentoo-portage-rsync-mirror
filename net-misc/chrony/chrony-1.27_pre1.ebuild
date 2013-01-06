# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.27_pre1.ebuild,v 1.3 2012/11/27 04:22:49 blueness Exp $

EAPI=4
inherit eutils toolchain-funcs

MY_P="${P/_/-}"
DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="caps +ipv6 +readline"

RDEPEND="
	readline? ( >=sys-libs/readline-4.1-r4 )
	caps? ( sys-libs/libcap )
"
DEPEND="${RDEPEND}"
DOCS=( examples/chrony.{conf,keys}.example )

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i examples/* chrony*.{1,5,8} faq.txt chrony.texi \
		-e "s:/etc/chrony\.:/etc/chrony/chrony.:g" \
		|| die
}

src_configure() {
	tc-export CC

	# not an autotools generated script
	./configure \
		$( use caps		 || echo --disable-linuxcaps ) \
		$( use ipv6		 || echo --disable-ipv6 ) \
		$( use readline	 || echo --disable-readline ) \
		--prefix=/usr \
		--sysconfdir=/etc/chrony \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${PF} \
		--without-nss \
		--without-tomcrypt \
		${EXTRA_ECONF} \
		|| die
}

src_compile() {
	emake all docs || die "make failed"
}

src_install() {
	default
	rm "${D}"/usr/share/doc/${PF}/COPYING || die
	doinfo chrony.info*

	newinitd "${FILESDIR}"/chronyd.rc chronyd
	newconfd "${FILESDIR}"/chronyd.conf chronyd

	keepdir /var/{lib,log}/chrony /etc/chrony

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/chrony.logrotate chrony
}
