# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/podbrowser/podbrowser-0.12.ebuild,v 1.4 2011/03/29 10:16:12 angelos Exp $

EAPI=1

DESCRIPTION="PodBrowser is a documentation browser for Perl"
HOMEPAGE="http://jodrell.net/projects/podbrowser"
SRC_URI="http://jodrell.net/files/podbrowser/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
SRC_TEST="do"

RDEPEND="dev-perl/gtk2-gladexml
	dev-perl/gtk2-perl
	dev-perl/HTML-Parser
	dev-perl/Locale-gettext
	virtual/perl-Pod-Simple
	dev-perl/URI
	dev-perl/Gtk2-Ex-PodViewer
	dev-perl/Gtk2-Ex-PrintDialog
	dev-perl/Gtk2-Ex-Simple-List
	>=dev-lang/perl-5.8.0
	x11-libs/gtk+:2
	>=x11-themes/gnome-icon-theme-2.10.0
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}"/Makefile.new "${S}"/Makefile
}
src_compile() {
	emake DESTDIR="${D}" PREFIX=/usr  || die "emake failed"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install || die
}
