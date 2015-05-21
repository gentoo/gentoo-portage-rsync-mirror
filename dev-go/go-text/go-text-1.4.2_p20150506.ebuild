# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-go/go-text/go-text-1.4.2_p20150506.ebuild,v 1.3 2015/05/21 06:57:23 zmedico Exp $

EAPI=5

KEYWORDS="~amd64"
DESCRIPTION="Go text processing support"
MY_PN=${PN##*-}
GO_PN=golang.org/x/${MY_PN}
HOMEPAGE="https://godoc.org/${GO_PN}"
EGIT_COMMIT="c93e7c9fff19fb9139b5ab04ce041833add0134e"
SRC_URI="https://github.com/golang/${MY_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/go-1.4"
RDEPEND=""
S="${WORKDIR}/src/${GO_PN}"
EGIT_CHECKOUT_DIR="${S}"
STRIP_MASK="*.a"

src_unpack() {
	default
	mkdir -p src/${GO_PN%/*} || die
	mv ${MY_PN}-${EGIT_COMMIT} src/${GO_PN} || die
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
		go test -run "^("$(
			echo -n 'Example(|_build|CanonType|Collator_Strings|Compacter|'
			echo -n 'Compose|DecodeWindows1252|Dictionary|Gen_build|'
			echo -n 'Gen_lookup|If|In|Iter|_lookup|Map|Matcher|Namer|Parent|'
			echo -n 'ParseAcceptLanguage|Parse_errors|Region_TLD|Remove|'
			echo -n 'RemoveFunc|Tag_Base|Tag_ComprehensibleTo|Tag_Region|'
			echo -n 'Tags|Tag_Script|Tag_values|Transformer_fold|'
			echo -n 'Transformer_narrow|Transformer_widen|UTF8Validator)|'
			echo -n 'Test(AcceptMinSize|AddLikelySubtags|Ambiguous|Append|'
			echo -n 'AppendNext|AppendString|AttrKey|Base|Basics|BestMatch|'
			echo -n 'Big5CircumflexAndMacron|BOMOverride|Bytes|Bytes|'
			echo -n 'BytesAllocation|Canonicalize|CaseMappings|'
			echo -n 'CaseProperties|CCC|Chain|ColElem|ColElem|Compare|'
			echo -n 'CompareWeights|Compose1|Compose2|Compose3|Composition|'
			echo -n 'Contains|Context|Contract|ConvertLarge|Coverage|'
			echo -n 'Currency|DecomposeSegment|DecomposeToLastBoundary|'
			echo -n 'Decomposition|DeepCopy|Discard|DoNorm|Enclosing|'
			echo -n 'EncodeInvalidUTF8|EncodeM49|EntryLess|EntrySort|'
			echo -n 'Equality|Errors|Expand|Files|Filter|FindField|'
			echo -n 'FindKeyAndType|FirstBoundary|FixCase|Flush|Fold|'
			echo -n 'FoldSingleRunes|GenColElems|GenerateTrie|GenIdxSort|'
			echo -n 'GenStates|Get|GetColElems|GetScriptID|Getters|'
			echo -n 'Grandfathered|Group|Implicit|In|Index|Index|Insert|'
			echo -n 'InsertAfter|InsertBefore|IsCountry|IsGroup|IsNormal|'
			echo -n 'IsNormalString|IsPrivateUse|IsRoot|Iter|IterNext|'
			echo -n 'IterSegmentation|Key|Key|KeyFromElems|LangID|Language|'
			echo -n 'LastBoundary|LookupContraction|LookupContraction|'
			echo -n 'LookupContraction|LookupTrie|MakeSlice|MakeString|Map|'
			echo -n 'MapAlloc|Mapping|MatchLang|Merge|Minimize|Narrow|'
			echo -n 'NarrowSingleRunes|NewCoverage|NextIndexed|NextWeight|'
			echo -n 'NonDigits|NonRepertoire|Nop|NotIn|Numeric|'
			echo -n 'NumericAppendNext|NumericCompare|NumericOverflow|'
			echo -n 'NumericWeighterAlloc|OffsetSort|Options|Parent|'
			echo -n 'ParentDistance|Parse|ParseAcceptLanguage|ParseBase|'
			echo -n 'ParseCurrency|ParseDraft|ParseExtensions|ParseRegion|'
			echo -n 'ParseScript|ParseTag|Path|PlaceHolder|Predicate|'
			echo -n 'PrintContractionTrieSet|ProcessWeights|QuickSpan|'
			echo -n 'Reader|Reader|Region|Region|RegionCanonicalize|'
			echo -n 'RegionDeprecation|RegionDistance|RegionID|RegionISO3|'
			echo -n 'RegionM49|RegionTLD|RegionType|Remove|Remove|'
			echo -n 'RemoveAlloc|RemoveFunc|Replacement|RuleProcessor|'
			echo -n 'Scan|Script|Script|Search|SelectAnyOf|SelectOnePerGroup|'
			echo -n 'Self|SetTypeForKey|ShortBuffersAndOverflow|Simplify|'
			echo -n 'Sort|String|String|StringAllocation|Supported|Supported|'
			echo -n 'TagSize|Transform|TransformNorm|TypeForKey|Update|'
			echo -n 'UpdateTertiary|UTF16|UTF8Validator|Widen|'
			echo -n 'WidenSingleRunes|WordBreaks|Writer))$') \
			-x -v ${GO_PN}/... || die $?
}

src_install() {
	exeinto /usr/lib/go/bin
	doexe "${WORKDIR}"/bin/*
	insinto /usr/lib/go
	find "${WORKDIR}"/{pkg,src} -name '.git*' -exec rm -rf {} \; 2>/dev/null
	doins -r "${WORKDIR}"/{pkg,src}
}
