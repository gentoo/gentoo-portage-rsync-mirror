# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-audio/gnome-audio-2.22.2.ebuild,v 1.11 2010/09/22 01:23:46 abcd Exp $

EAPI=3

inherit gnome2

DESCRIPTION="Gnome Desktop Sound Effects Package"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="public-domain CCPL-Attribution-ShareAlike-2.0 CCPL-Attribution-3.0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND=""

src_configure() { :; }

src_compile() { :; }

src_install() {
	emake DESTDIR="${ED}" install || die "installation failed"
	dodoc ChangeLog README
}
