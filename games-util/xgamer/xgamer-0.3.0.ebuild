# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xgamer/xgamer-0.3.0.ebuild,v 1.6 2014/08/09 23:10:57 zlogene Exp $

EAPI=5
inherit perl-module

DESCRIPTION="A launcher for starting games in a second X session"
HOMEPAGE="http://code.google.com/p/xgamer/"
SRC_URI="http://xgamer.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8
	>=x11-libs/gtk+-2.16:2
	>=dev-perl/gtk2-perl-1.120
	>=x11-wm/openbox-3.0.0
	virtual/perl-File-Spec
	dev-perl/File-BaseDir
	dev-perl/XML-Twig
	dev-perl/glib-perl
	x11-misc/numlockx
	media-gfx/feh"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

S=${WORKDIR}/${PN}
