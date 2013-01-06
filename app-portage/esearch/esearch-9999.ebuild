# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-9999.ebuild,v 1.5 2012/12/11 08:17:36 fuzzyray Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] *-jython 2.7-pypy-*"
PYTHON_USE_WITH="readline"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

inherit distutils python git-2

EGIT_REPO_URI="git://github.com/fuzzyray/esearch.git"

DESCRIPTION="Replacement for 'emerge --search' with search-index"
HOMEPAGE="http://david-peter.de/esearch.html"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE="linguas_fr linguas_it"

KEYWORDS=""

DEPEND="sys-apps/portage"
RDEPEND="${DEPEND}"

distutils_src_compile_pre_hook() {
	echo VERSION="9999-${EGIT_VERSION}" "$(PYTHON)" setup.py set_version
	VERSION="9999-${EGIT_VERSION}" "$(PYTHON)" setup.py set_version
}

src_compile() {
	distutils_src_compile
}

src_install() {
	python_convert_shebangs -r "" build-*/scripts-*
	distutils_src_install
	dodoc eupdatedb.cron || die "dodoc failed"

	# Remove unused man pages according to the linguas flags
	if ! use linguas_fr ; then
		rm -rf "${ED}"/usr/share/man/fr \
			|| die "rm failed to remove ${ED}/usr/share/man/fr"
	fi

	if ! use linguas_it ; then
		rm -rf "${ED}"/usr/share/man/it \
			|| die "rm failed to remove ${ED}/usr/share/man/it"
	fi
}
