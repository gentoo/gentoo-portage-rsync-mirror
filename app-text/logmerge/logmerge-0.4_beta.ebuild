# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/logmerge/logmerge-0.4_beta.ebuild,v 1.1 2013/03/26 17:33:44 tomwij Exp $

EAPI="5"

MY_PV="${PV/_/-}"
DESCRIPTION="Merge multiple logs such that multilined entries appear in chronological order without breaks."
HOMEPAGE="https://code.google.com/p/${PN}/"
SRC_URI="https://${PN}.googlecode.com/files/${PN}-${MY_PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"

src_install() {
	dobin ${PN}
}