# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/pwclient/pwclient-20121105131501.ebuild,v 1.1 2012/12/01 22:41:40 vapier Exp $

EAPI="4"

# The PV comes from:
#	git clone ${EGIT_REPO_URI}
#	cd patchwork
#	EGIT_COMMIT=$(git log -n1 --format=%H apps/patchwork/bin/pwclient)
#	date --date="$(git log -n1 --format=%ci ${EGIT_COMMIT})" -u +%Y%m%d%H%M%S
EGIT_REPO_URI="git://ozlabs.org/home/jk/git/patchwork"
EGIT_COMMIT="bc695f5a7e0a2dd184dc0eae7a923be24b1b1723"

DESCRIPTION="command line utility for interacting with patchwork repos"
HOMEPAGE="http://jk.ozlabs.org/projects/patchwork/"
SRC_URI="http://repo.or.cz/w/patchwork.git/blob_plain/${EGIT_COMMIT}:/apps/patchwork/bin/pwclient -> ${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python"

S=${WORKDIR}

src_unpack() { :; }

src_install() {
	newbin "${DISTDIR}"/${P} ${PN}
}
