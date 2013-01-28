# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-sounds/kdeartwork-sounds-4.9.5.ebuild,v 1.4 2013/01/27 23:13:37 ago Exp $

EAPI=4

RESTRICT="binchecks strip"

KMMODULE="sounds"
KMNAME="kdeartwork"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Extra sound themes for kde"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE=""
