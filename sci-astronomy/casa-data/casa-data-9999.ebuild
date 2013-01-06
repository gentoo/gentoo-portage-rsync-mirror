# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/casa-data/casa-data-9999.ebuild,v 1.2 2012/08/05 17:28:03 bicatali Exp $

EAPI=4
inherit subversion

ESVN_REPO_URI="https://svn.cv.nrao.edu/svn/casa-data/distro"
ESVN_OPTIONS="--non-interactive --trust-server-cert "

DESCRIPTION="Data and tables for the CASA software"
HOMEPAGE="https://safe.nrao.edu/wiki/bin/view/Software/ObtainingCasaDataRepository"
SRC_URI=""

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/distro"

src_install(){
	insinto /usr/share/casa/data
	doins -r *
}
