# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-go/go-tools/go-tools-9999.ebuild,v 1.5 2015/05/28 07:11:30 zmedico Exp $

EAPI=5
inherit git-r3

KEYWORDS=""
DESCRIPTION="Go Tools"
MY_PN=${PN##*-}
GO_PN=golang.org/x/${MY_PN}
HOMEPAGE="https://godoc.org/${GO_PN}"
EGIT_REPO_URI="https://go.googlesource.com/${MY_PN}"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/go-1.4
	dev-go/go-net"
RDEPEND=""
S="${WORKDIR}/src/${GO_PN}"
EGIT_CHECKOUT_DIR="${S}"
STRIP_MASK="*.a"

src_prepare() {
	# disable broken tests
	sed -e 's:TestWeb(:_\0:' -i cmd/godoc/godoc_test.go || die
	sed -e 's:TestVet(:_\0:' -i cmd/vet/vet_test.go || die
	sed -e 's:TestImport(:_\0:' -i go/gcimporter/gcimporter_test.go || die
	sed -e 's:TestImportStdLib(:_\0:' -i go/importer/import_test.go || die
	sed -e 's:TestStdlib(:_\0:' -i go/loader/stdlib_test.go || die
	sed -e 's:TestStdlib(:_\0:' -i go/ssa/stdlib_test.go || die
	sed -e 's:TestGorootTest(:_\0:' \
		-e 's:TestFoo(:_\0:' \
		-e 's:TestTestmainPackage(:_\0:' \
		-i go/ssa/interp/interp_test.go || die
	sed -e 's:TestBar(:_\0:' \
		-e 's:TestFoo(:_\0:' -i go/ssa/interp/testdata/a_test.go || die
	sed -e 's:TestCheck(:_\0:' -i go/types/check_test.go || die
	sed -e 's:TestStdlib(:_\0:' \
		-e 's:TestStdFixed(:_\0:' \
		-e 's:TestStdKen(:_\0:' -i go/types/stdlib_test.go || die
	sed -e 's:TestRepoRootForImportPath(:_\0:' -i go/vcs/vcs_test.go || die
	sed -e 's:TestStdlib(:_\0:' -i refactor/lexical/lexical_test.go || die
}

src_compile() {
	# Create a writable GOROOT in order to avoid sandbox violations.
	GOROOT="${WORKDIR}/goroot"
	cp -sR "${EPREFIX}"/usr/lib/go "${GOROOT}" || die
	rm -rf "${GOROOT}/src/${GO_PN}" \
		"${GOROOT}/pkg/linux_${ARCH}/${GO_PN}" || die
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} go install -v -x -work ${GO_PN}/... || die
}

src_test() {
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} \
		go test -x -v ${GO_PN}/... || die $?
}

src_install() {
	local x
	exeinto /usr/lib/go/bin
	doexe "${WORKDIR}"/bin/*

	# godoc ends up in ${GOROOT}/bin
	dodir /usr/bin
	while read -r -d '' x; do
		doexe "${x}"
		ln "${ED}"usr/{lib/go/bin,bin}/${x##*/} || die
	done < <(find "${GOROOT}/bin" -type f -print0)

	# cover and vet end up in ${GOROOT}/pkg/tool/linux_amd64
	exeinto /usr/lib/go/pkg/tool/linux_amd64
	find "${GOROOT}/pkg/tool/linux_amd64" -type f -exec doexe {} \;

	insinto /usr/lib/go
	find "${WORKDIR}"/{pkg,src} -name '.git*' -exec rm -rf {} \; 2>/dev/null
	doins -r "${WORKDIR}"/{pkg,src}
}
