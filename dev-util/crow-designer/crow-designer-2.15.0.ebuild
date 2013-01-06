# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crow-designer/crow-designer-2.15.0.ebuild,v 1.6 2012/05/04 17:51:44 jdhore Exp $

EAPI="2"
inherit eutils

DESCRIPTION="GTK+ GUI building tool"
HOMEPAGE="http://www.crowdesigner.org"
SRC_URI="http://nothing-personal.googlecode.com/files/crow-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/guiloader-2.15
	>=dev-libs/guiloader-c++-2.15
	dev-cpp/gtkmm:2.4
	>=dev-libs/dbus-glib-0.76"
DEPEND="${RDEPEND}
	dev-libs/boost
	virtual/pkgconfig"

S=${WORKDIR}/crow-${PV}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{authors.txt,news.{en,ru}.txt,readme.{en,ru}.txt,readme.ru.txt} || die
}
