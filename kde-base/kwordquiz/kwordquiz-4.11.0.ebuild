# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwordquiz/kwordquiz-4.11.0.ebuild,v 1.1 2013/08/14 20:24:11 dilfridge Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE: A powerful flashcard and vocabulary learning program"
HOMEPAGE="http://kde.org/applications/education/kwordquiz
http://edu.kde.org/kwordquiz"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND=${DEPEND}
