# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/coinor-sample/coinor-sample-1.2.9.ebuild,v 1.1 2014/01/14 17:48:58 bicatali Exp $

EAPI=5

inherit autotools-utils

MYPN=Sample

DESCRIPTION="COIN-OR Sample models"
HOMEPAGE="https://projects.coin-or.org/svn/Data/Sample"
SRC_URI="http://www.coin-or.org/download/source/Data/${MYPN}-${PV}.tgz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYPN}-${PV}"
