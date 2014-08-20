# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artikulate/artikulate-4.14.0.ebuild,v 1.1 2014/08/20 16:02:47 johu Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
KDE_HANDBOOK="optional"
inherit kde4-base multilib

DESCRIPTION="Language learning application that helps improving pronunciation skills"
HOMEPAGE="http://edu.kde.org/applications/language/artikulate"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	dev-qt/qtxmlpatterns:4
	>=media-libs/qt-gstreamer-1.2.0
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kqtquickcharts)
"
