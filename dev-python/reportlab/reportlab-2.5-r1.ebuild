# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reportlab/reportlab-2.5-r1.ebuild,v 1.5 2013/06/08 14:34:44 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils versionator prefix

DESCRIPTION="Tools for generating printable PDF documents from any data source."
HOMEPAGE="http://www.reportlab.com/ http://pypi.python.org/pypi/reportlab"
SRC_URI="http://www.reportlab.com/ftp/${P}.tar.gz
	http://www.reportlab.com/ftp/fonts/pfbfer-20070710.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-fbsd ~x86-linux"
IUSE="doc examples test"

DEPEND="virtual/python-imaging
	media-fonts/ttf-bitstream-vera
	media-libs/libart_lgpl
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_unpack() {
	unpack ${P}.tar.gz
	cd ${P}/src/reportlab/fonts || die
	unpack pfbfer-20070710.zip
}

src_prepare() {
	distutils_src_prepare

	sed -i \
		-e 's|/usr/lib/X11/fonts/TrueType/|/usr/share/fonts/ttf-bitstream-vera/|' \
		-e 's|/usr/local/Acrobat|/opt/Acrobat|g' \
		-e 's|%(HOME)s/fonts|%(HOME)s/.fonts|g' \
		src/reportlab/rl_config.py || die "sed failed"

	epatch "${FILESDIR}/${PN}-2.2_qa_msg.patch"

	rm -fr src/rl_addons/renderPM/libart_lgpl
	epatch "${FILESDIR}/${PN}-2.4-external_libart_lgpl.patch"

	epatch "${FILESDIR}/${PN}-2.5-pypy-implicit-PyArg_NoArgs.patch"
	eprefixify setup.py
}

src_compile() {
	distutils_src_compile

	# One of tests already builds documentation.
	if use doc && ! use test; then
		cd docs
		PYTHONPATH="$(ls -d ../build-$(PYTHON -f --ABI)/lib.*)" "$(PYTHON -f)" genAll.py || die "genAll.py failed"
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py tests-preinstall
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		# docs/reference/reportlab-reference.pdf is identical with docs/reportlab-reference.pdf
		rm -f docs/reference/reportlab-reference.pdf

		insinto /usr/share/doc/${PF}
		doins -r docs/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demos || die "Installation of examples failed"
		insinto /usr/share/doc/${PF}/tools/pythonpoint
		doins -r tools/pythonpoint/demos || die "Installation of examples failed"
	fi
}
