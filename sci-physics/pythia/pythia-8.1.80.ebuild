# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/pythia/pythia-8.1.80.ebuild,v 1.1 2013/10/29 22:04:54 bicatali Exp $

EAPI=5

inherit eutils versionator toolchain-funcs multilib

MV=$(get_major_version)
MY_P=${PN}$(replace_all_version_separators "" ${PV})

DESCRIPTION="Lund Monte Carlo high-energy physics event generator"
HOMEPAGE="http://pythia8.hepforge.org/"
SRC_URI="http://home.thep.lu.se/~torbjorn/${PN}${MV}/${MY_P}.tgz"

SLOT="8"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples gzip +hepmc static-libs"

DEPEND="
	gzip? ( dev-libs/boost sys-libs/zlib )
	hepmc? ( sci-physics/hepmc )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	PYTHIADIR="${EPREFIX}/usr/share/pythia8"
	# set datadir for xmldor in include file
	sed -i \
		-e "s:../xmldoc:${PYTHIADIR}/xmldoc:" \
		include/Pythia8/Pythia.h || die
	# respect libdir, prefix, flags
	sed -i \
		-e "s:/lib:/$(get_libdir):g" \
		-e "s:/usr:${EPREFIX}/usr:g" \
		-e "s:-O2::g" \
		configure || die
	sed -i \
		-e "s:LIBDIR=.*:LIBDIR=$(get_libdir):" \
		-e "s:LIBDIRARCH=.*:LIBDIRARCH=$(get_libdir):" \
		-e "s:cp -r lib:cp -r $(get_libdir):" \
		-e '/ln -fs/d' \
		Makefile examples/Makefile || die
}

src_configure() {
	export USRCXXFLAGS="${CXXFLAGS}"
	export USRLDFLAGSSHARED="${LDFLAGS}"
	tc-export CC CXX
	# homemade configure script
	./configure \
		--installdir="${EPREFIX}/usr" \
		--datadir="${PYTHIADIR}" \
		--enable-shared \
		$(usex gzip "--enable-gzip=yes" "") \
		$(usex hepmc "--with-hepmcversion=2 --with-hepmc=${EPREFIX}/usr" "") \
		|| die
	if ! use static-libs; then
		sed -i \
			-e '/targets.*=$(LIBDIR.*\.a$/d' \
			-e 's/+=\(.*libpythia8\.\)/=\1/' \
			Makefile || die
		sed -i \
			-e 's:\.a:\.so:g' \
			-e 's:$(LIBDIRARCH):$(LIBDIR):g' \
			examples/Makefile || die
	fi
}

src_test() {
	cd examples || die
	# use emake for parallel instead of long runmains
	emake main0{1..9}
	for i in main0{1..9}*.exe; do
		LD_LIBRARY_PATH="${S}/$(get_libdir):${LD_LIBRARY_PATH}" \
			./${i} > ${i}.out || die "test ${i} failed"
	done
	if use hepmc; then
		emake main31
		LD_LIBRARY_PATH="${S}/$(get_libdir):${LD_LIBRARY_PATH}" \
			./main31.exe > main31.exe.out || die
	fi
	emake clean && rm main*out
}

src_install() {
	emake INSTALLDIR="${ED}/usr" DATADIR="${D}/${PYTHIADIR}" install
	rm -r "${D}"/${PYTHIADIR}/{html,php}doc || die
	echo "PYTHIA8DATA=${PYTHIADIR}/xmldoc" >> 99pythia8
	doenvd 99pythia8

	dodoc GUIDELINES AUTHORS README
	if use doc; then
		dodoc worksheet.pdf
		dohtml -r htmldoc/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
