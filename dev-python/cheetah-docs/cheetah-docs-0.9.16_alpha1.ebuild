# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah-docs/cheetah-docs-0.9.16_alpha1.ebuild,v 1.7 2011/11/28 20:10:54 hwoarang Exp $

DESCRIPTION="Documentation for Cheetah templates."
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/CheetahDocs-${PV/_alpha/a}.tgz"

IUSE=""
LICENSE="OPL"
KEYWORDS="~amd64 ~ia64 ppc x86"
SLOT="0"

DEPEND=""

S=${WORKDIR}/CheetahDocs

src_install() {
	find . -name CVS -or -iname "*~" -exec rm -rf '{}' \;

	dodoc *.txt TODO
	dohtml -r devel_guide_html devel_guide_html_multipage \
		users_guide_html users_guide_html_multipage \
		OnePageTutorial.html

	# Install the source code.
	insinto /usr/share/doc/${PF}
	doins -r devel_guide_src users_guide_src

	doins *.ps *.pdf
}
