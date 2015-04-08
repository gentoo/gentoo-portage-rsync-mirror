# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/votca-csgapps/votca-csgapps-1.2.4.ebuild,v 1.4 2015/03/16 08:23:53 ago Exp $

EAPI=4

inherit cmake-utils

if [ "${PV}" != "9999" ]; then
	SRC_URI="http://downloads.votca.googlecode.com/hg/${PF}.tar.gz"
else
	inherit mercurial
	EHG_REPO_URI="https://csgapps.votca.googlecode.com/hg"
fi

DESCRIPTION="Extra applications for votca-csg"
HOMEPAGE="http://www.votca.org"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-macos"
IUSE=""

RDEPEND="~sci-chemistry/${PN%apps}-${PV}"

DEPEND="${RDEPEND}"

DOCS=( README )
