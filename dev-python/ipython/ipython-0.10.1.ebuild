# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipython/ipython-0.10.1.ebuild,v 1.7 2012/08/26 18:48:25 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
# When a new version of this package supports Python 3, then 3.* Python ABIs should be unrestricted in dev-python/ipdb.
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils elisp-common eutils

DESCRIPTION="An advanced interactive shell for Python."
HOMEPAGE="http://ipython.scipy.org/ http://pypi.python.org/pypi/ipython"
SRC_URI="http://ipython.scipy.org/dist/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc emacs examples gnuplot readline smp test wxwidgets"

CDEPEND="dev-python/pexpect
	wxwidgets? ( dev-python/wxpython )
	readline? ( sys-libs/readline )
	emacs? ( app-emacs/python-mode virtual/emacs )
	smp? (  net-zope/zope-interface
			dev-python/foolscap
			dev-python/pyopenssl )"
RDEPEND="${CDEPEND}
	gnuplot? ( dev-python/gnuplot-py )"
DEPEND="${CDEPEND}
	test? ( dev-python/nose )"

SITEFILE="62ipython-gentoo.el"
DOCS="docs/source/changes.txt"
PYTHON_MODNAME="IPython"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.1-globalpath.patch
	sed -i \
		-e "s:share/doc/ipython:share/doc/${PF}:" \
		setupbase.py || die "sed failed"
	if ! use doc; then
		sed -i \
			-e '/extensions/d' \
			-e 's/+ manual_files//' \
			setupbase.py || die "sed failed"
	fi
	if ! use examples; then
		sed -i \
			-e 's/+ example_files//' \
			setupbase.py || die "sed failed"
	fi
}

src_compile() {
	distutils_src_compile
	if use emacs; then
		elisp-compile docs/emacs/ipython.el || die "elisp-compile failed"
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --home="${WORKDIR}/test-${PYTHON_ABI}" > /dev/null || die "Installation for tests failed with $(python_get_implementation) $(python_get_version)"
		pushd "${WORKDIR}/test-${PYTHON_ABI}" > /dev/null
		# First initialize .ipython stuff.
		PATH="${WORKDIR}/test-${PYTHON_ABI}/bin:${PATH}" PYTHONPATH="${WORKDIR}/test-${PYTHON_ABI}/lib/python" ipython > /dev/null <<-EOF
		EOF
		# Run tests (-v for more verbosity).
		PATH="${WORKDIR}/test-${PYTHON_ABI}/bin:${PATH}" PYTHONPATH="${WORKDIR}/test-${PYTHON_ABI}/lib/python" iptest -v
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use emacs; then
		pushd docs/emacs > /dev/null
		elisp-install ${PN} ${PN}.el* || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
		popd > /dev/null
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	use emacs && elisp-site-regen
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}
