# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unrtf/unrtf-0.20.1.ebuild,v 1.14 2009/09/06 20:45:35 ranger Exp $

inherit eutils

MY_P="${P/-/_}"
DESCRIPTION="Converts RTF files to various formats"
HOMEPAGE="http://www.gnu.org/software/unrtf/unrtf.html"
#SRC_URI="mirror://gentoo/${P}.tar.gz"
SRC_URI="http://www.gnu.org/software/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog NEWS README AUTHORS
}
