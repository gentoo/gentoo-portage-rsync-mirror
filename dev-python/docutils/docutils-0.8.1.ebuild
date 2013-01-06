# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/docutils/docutils-0.8.1.ebuild,v 1.11 2012/10/07 00:44:32 floppym Exp $

EAPI="3"
PYTHON_DEPEND="*::3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.3"

inherit distutils eutils

DESCRIPTION="Docutils - Python Documentation Utilities"
HOMEPAGE="http://docutils.sourceforge.net/ http://pypi.python.org/pypi/docutils"
if [[ "${PV}" == *_pre* ]]; then
	SRC_URI="mirror://gentoo/${P}.tar.xz"
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
fi
SRC_URI+=" glep? ( mirror://gentoo/glep-0.4-r1.tbz2 )"

LICENSE="BSD-2 GPL-3 PSF-2 public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="glep"

DEPEND="dev-python/setuptools"
RDEPEND=""

DOCS="*.txt"
PYTHON_MODNAME="docutils roman.py"

GLEP_SRC="${WORKDIR}/glep-0.4-r1"

src_prepare() {
	# Fix installation of extra modules.
	epatch "${FILESDIR}/${PN}-0.6-extra_modules.patch"

	sed -e "s/from distutils.core/from setuptools/" -i setup.py || die "sed setup.py failed"
}

src_compile() {
	distutils_src_compile

	# Generate html docs from reStructured text sources.

	# Make roman.py available for process of building of documentation.
	ln -s extras/roman.py

	# Place html4css1.css in base directory to ensure that the generated reference to it is correct.
	cp docutils/writers/html4css1/html4css1.css .

	pushd tools > /dev/null

	echo PYTHONPATH="../build-$(PYTHON -f --ABI)/lib" "$(PYTHON -f)" $([[ -f ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py ]] && echo ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py || echo ../tools/buildhtml.py) --input-encoding=utf-8 --stylesheet-path=../html4css1.css --traceback ../docs
	PYTHONPATH="../build-$(PYTHON -f --ABI)/lib" "$(PYTHON -f)" $([[ -f ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py ]] && echo ../build-$(PYTHON -f --ABI)/lib/tools/buildhtml.py || echo ../tools/buildhtml.py) --input-encoding=utf-8 --stylesheet-path=../html4css1.css --traceback ../docs || die "buildhtml.py failed"

	popd > /dev/null

	# Clean up after building of documentation.
	rm roman.py html4css1.css
}

src_test() {
	testing() {
		echo PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" $([[ -f build-${PYTHON_ABI}/lib/test/alltests.py ]] && echo build-${PYTHON_ABI}/lib/test/alltests.py || echo test/alltests.py)
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" $([[ -f build-${PYTHON_ABI}/lib/test/alltests.py ]] && echo build-${PYTHON_ABI}/lib/test/alltests.py || echo test/alltests.py)
	}
	python_execute_function testing
}

install_txt_doc() {
	local doc="${1}"
	local dir="txt/$(dirname ${doc})"
	docinto "${dir}"
	dodoc "${doc}"
}

src_install() {
	distutils_src_install

	postinstallational_preparation() {
		# Install tools.
		mkdir -p "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
		pushd $([[ -d build-${PYTHON_ABI}/lib/tools ]] && echo build-${PYTHON_ABI}/lib/tools || echo tools) > /dev/null
		cp buildhtml.py quicktest.py "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
		popd > /dev/null

		# Delete useless files, which are installed only with Python 3.
		rm -fr "${ED}$(python_get_sitedir)/"{test,tools}
	}
	python_execute_function -q postinstallational_preparation
	python_merge_intermediate_installation_images "${T}/images"

	# Install documentation.
	dohtml -r docs tools

	# Install stylesheet file.
	insinto /usr/share/doc/${PF}/html
	doins docutils/writers/html4css1/html4css1.css
	local doc
	for doc in $(find docs tools -name "*.txt"); do
		install_txt_doc "${doc}"
	done

	# Install Gentoo GLEP tools.
	if use glep; then
		dobin "${GLEP_SRC}/glep.py" || die "dobin failed"

		installation_of_glep_tools() {
			insinto $(python_get_sitedir)/docutils/readers
			newins "${GLEP_SRC}/glepread.py" glep.py || die "newins reader failed"
			insinto $(python_get_sitedir)/docutils/transforms
			newins "${GLEP_SRC}/glepstrans.py" gleps.py || die "newins transform failed"
			insinto $(python_get_sitedir)/docutils/writers
			doins -r "${GLEP_SRC}/glep_html" || die "doins writer failed"
		}
		python_execute_function --action-message 'Installation of GLEP tools with $(python_get_implementation_and_version)...' installation_of_glep_tools
	fi
}
