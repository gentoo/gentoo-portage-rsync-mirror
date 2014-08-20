# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blinken/blinken-4.14.0.ebuild,v 1.1 2014/08/20 16:02:53 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE version of the Simon Says game"
HOMEPAGE="http://www.kde.org/applications/education/blinken
http://edu.kde.org/blinken"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

src_install() {
	kde4-base_src_install

	rm "${D}"/usr/share/apps/${PN}/README.packagers
}
