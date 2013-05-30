# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/akonadi-git-resource/akonadi-git-resource-0_p20130522.ebuild,v 1.2 2013/05/30 11:39:16 kensington Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Git commit integration in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-git-resource"
LICENSE="GPL-2"

SRC_URI="http://dev.gentoo.org/~johu/distfiles/${P}.tar.xz"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	=dev-libs/libgit2-0.17*
"
