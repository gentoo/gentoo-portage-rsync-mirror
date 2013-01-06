# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/akonadi-git-resource/akonadi-git-resource-0_p20120222.ebuild,v 1.1 2012/02/22 16:27:01 johu Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Git commit integration in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-git-resource"
LICENSE="GPL-2"

SRC_URI="http://dev.gentoo.org/~johu/distfiles/${P}.tar.xz"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	=dev-libs/libgit2-0.16*
"

S=${WORKDIR}
