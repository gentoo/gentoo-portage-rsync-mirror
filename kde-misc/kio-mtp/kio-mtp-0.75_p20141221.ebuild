# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-mtp/kio-mtp-0.75_p20141221.ebuild,v 1.1 2015/01/21 07:18:43 mrueg Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="MTP KIO-Client for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-mtp"
COMMIT_ID="c418634e4216279fcedfa5cc14f20bda7672b609"
SRC_URI="http://quickgit.kde.org/?p=kio-mtp.git&a=snapshot&h=${COMMIT_ID}&fmt=tgz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${PN}

DEPEND="
	>=media-libs/libmtp-1.1.3
"
RDEPEND="${DEPEND}"
