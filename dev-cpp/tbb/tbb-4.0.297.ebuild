# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tbb/tbb-4.0.297.ebuild,v 1.11 2012/09/13 22:37:22 bicatali Exp $

EAPI=4
inherit eutils flag-o-matic multilib versionator toolchain-funcs

# those 2 below change pretty much every release
# url number
MYU="78/181"
# release update
MYR="%20update%203"

PV1="$(get_version_component_range 1)"
PV2="$(get_version_component_range 2)"
PV3="$(get_version_component_range 3)"
MYP="${PN}${PV1}${PV2}_${PV3}oss"

DESCRIPTION="High level abstract threading library"
HOMEPAGE="http://www.threadingbuildingblocks.org/"
SRC_URI="http://www.threadingbuildingblocks.org/uploads/${MYU}/${PV1}.${PV2}${MYR}/${MYP}_src.tgz"
LICENSE="GPL-2-with-exceptions"

SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="debug doc examples"
# FIXME
# https://bugs.gentoo.org/show_bug.cgi?id=412675#c10
# restricting test for stabilization
#RESTRICT="test"

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-3.0.104-tests.patch \
		"${FILESDIR}"/${PN}-4.0.297-underlinking.patch \
		"${FILESDIR}"/${PN}-4.0.297-ldflags.patch
	# use fully qualified compilers. do not force pentium4 for x86 users
	sed -i \
		-e "s/-O2/${CXXFLAGS}/g" \
		-e "/CPLUS/s/g++/$(tc-getCXX)/g" \
		-e "/CONLY/s/gcc/$(tc-getCC)/g" \
		-e "s/gcc -/$(tc-getCC) -v/g" \
		-e '/CPLUS_FLAGS +=/s/-march=pentium4//' \
		-e 's/-m64//g' \
		build/*.inc || die
	# - Strip the $(shell ... >$(NUL) 2>$(NUL)) wrapping, leaving just the
	#   actual command.
	# - Force generation of version_string.tmp immediately after the directory
	#   is created.  This avoids a race when the user builds tbb and tbbmalloc
	#   concurrently.  The choice of Makefile.tbb (instead of
	#   Makefile.tbbmalloc) is arbitrary.
	sed -i \
		-e 's/^\t\$(shell \(.*\) >\$(NUL) 2>\$(NUL))\s*/\t\1/' \
		-e 's!^\t@echo Created \$(work_dir)_\(debug\|release\).*$!&\n\t$(MAKE) -C "$(work_dir)_\1"  -r -f $(tbb_root)/build/Makefile.tbb cfg=\1 tbb_root=$(tbb_root) version_string.tmp!' \
		src/Makefile || die
	find include -name \*.html -delete

	cat <<-EOF > ${PN}.pc
		prefix=${EPREFIX}/usr
		libdir=\${prefix}/$(get_libdir)
		includedir=\${prefix}/include
		Name: ${PN}
		Description: ${DESCRIPTION}
		Version: ${PV}
		URL: ${HOMEPAGE}
		Libs: -L\${libdir} -ltbb -ltbbmalloc
		Cflags: -I\${includedir}/tbb
	EOF
}

src_compile() {
	# wrt #418453#c3
	append-ldflags $(no-as-needed)

	if [[ $(tc-getCXX) == *g++ ]]; then
		myconf="compiler=gcc"
	elif [[ $(tc-getCXX) == *ic*c ]]; then
		myconf="compiler=icc"
	fi
	local ccconf="${myconf}"
	if use debug || use examples; then
		ccconf="${ccconf} tbb_debug tbbmalloc_debug"
	fi
	emake -C src ${ccconf} tbb_release tbbmalloc_release
}

src_test() {
	local ccconf="${myconf}"
	if use debug || use examples; then
		${ccconf}="${myconf} test_debug tbbmalloc_test_debug"
	fi
	emake -C src ${ccconf} test_release
}

src_install(){
	local l
	for l in $(find build -name lib\*.so.\*); do
		dolib.so ${l}
		local bl=$(basename ${l})
		dosym ${bl} /usr/$(get_libdir)/${bl%.*}
	done
	insinto /usr
	doins -r include
	insinto /usr/$(get_libdir)/pkgconfig
	doins ${PN}.pc
	dodoc README CHANGES doc/Release_Notes.txt
	use doc && dohtml -r doc/html/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples/build
		doins build/*.inc
		insinto /usr/share/doc/${PF}/examples
		doins -r examples
	fi
}
