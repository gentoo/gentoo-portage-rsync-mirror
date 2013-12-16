# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/linkchecker/linkchecker-9999.ebuild,v 1.2 2013/12/16 10:54:30 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite?"

inherit bash-completion-r1 distutils-r1 eutils git-r3 multilib

MY_P="${P/linkchecker/LinkChecker}"

DESCRIPTION="Check websites for broken links"
HOMEPAGE="http://wummel.github.com/linkchecker/ http://pypi.python.org/pypi/linkchecker/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/wummel/linkchecker.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="bash-completion clamav geoip gnome login nagios sqlite syntax-check X"

RDEPEND="
	dev-python/dnspython[${PYTHON_USEDEP}]
	bash-completion? ( dev-python/optcomplete[${PYTHON_USEDEP}] )
	clamav? ( app-antivirus/clamav )
	geoip? ( dev-python/geoip-python[${PYTHON_USEDEP}] )
	gnome? ( dev-python/pygtk:2[${PYTHON_USEDEP}] )
	login? ( dev-python/twill[${PYTHON_USEDEP}] )
	syntax-check? (
		dev-python/cssutils[${PYTHON_USEDEP}]
		dev-python/utidylib[${PYTHON_USEDEP}]
		)
	X? (
		dev-python/PyQt4[X,help,${PYTHON_USEDEP}]
		dev-python/qscintilla-python[${PYTHON_USEDEP}]
		)"
DEPEND="
	X? (
	dev-qt/qthelp:4
	dev-python/markdown2[${PYTHON_USEDEP}]
		)"

RESTRICT="test"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}"/${PN}-8.3-unbundle.patch
		"${FILESDIR}"/${PN}-8.0-desktop.patch
		)

	emake -C doc/html

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	if ! use X; then
		delete_gui() {
				rm -rf \
					"${ED}"/usr/bin/linkchecker-gui* \
					"${ED}"/$(python_get_sitedir)/linkcheck/gui* || die
		}
		python_foreach_impl delete_gui
	fi
	dohtml doc/html/*
	use bash-completion && dobashcomp config/linkchecker-completion
	if use nagios; then
		insinto /usr/$(get_libdir)/nagios/plugins
		doins linkchecker-nagios
	else
		rm -f "${ED}"/usr/bin/linkchecker-nagios* || die
	fi
}
