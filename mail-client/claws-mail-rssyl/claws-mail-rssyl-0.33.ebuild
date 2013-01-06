# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-rssyl/claws-mail-rssyl-0.33.ebuild,v 1.5 2012/10/31 18:47:09 nativemad Exp $

EAPI="4"

inherit eutils multilib

MY_P="${P#claws-mail-}"

DESCRIPTION="Read your favorite newsfeeds in Claws Mail. RSS 1.0, 2.0 and Atom feeds are currently supported"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE="nls"
RDEPEND=">=mail-client/claws-mail-3.8.1
	net-misc/curl
	dev-libs/libxml2
	nls? ( >=sys-devel/gettext-0.12.1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README || die

	# kill useless files
	rm -f "${D}"/usr/$(get_libdir)/claws-mail/plugins/*.{a,la}
}
