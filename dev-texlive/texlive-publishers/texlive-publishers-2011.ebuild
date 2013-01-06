# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-publishers/texlive-publishers-2011.ebuild,v 1.12 2012/10/03 18:25:47 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="ANUfinalexam IEEEconf IEEEtran aastex acmconf active-conf afthesis aguplus aiaa ametsoc aomart apa apa6e arsclassica asaetr ascelike beamer-FUBerlin chem-journal classicthesis cmpj confproc dfgproposal ebsthesis economic elbioimp elsarticle elteikthesis erdc estcpmm euproposal fbithesis gaceta gatech-thesis har2nat icsv ieeepes ijmart imac imtekda jmlr jpsj kluwer lps macqassign mentis msuthesis muthesis nature nddiss nih nostarch nrc onrannual philosophersimprint powerdot-FUBerlin pracjourn procIAGssymp ptptex psu-thesis revtex revtex4 ryethesis sageep seuthesis soton spie stellenbosch suftesi sugconf texilikechaps texilikecover thesis-titlepage-fhac thuthesis toptesi tugboat tugboat-plain uaclasses uafthesis ucdavisthesis ucthesis uiucthesis umthesis umich-thesis unamthesis ut-thesis uothesis uowthesis uwthesis vancouver vxu york-thesis collection-publishers
"
TEXLIVE_MODULE_DOC_CONTENTS="ANUfinalexam.doc IEEEconf.doc IEEEtran.doc aastex.doc acmconf.doc active-conf.doc afthesis.doc aguplus.doc aiaa.doc ametsoc.doc aomart.doc apa.doc apa6e.doc arsclassica.doc asaetr.doc ascelike.doc beamer-FUBerlin.doc classicthesis.doc cmpj.doc confproc.doc dfgproposal.doc ebsthesis.doc economic.doc elbioimp.doc elsarticle.doc elteikthesis.doc erdc.doc estcpmm.doc euproposal.doc fbithesis.doc gaceta.doc gatech-thesis.doc har2nat.doc icsv.doc ieeepes.doc ijmart.doc imac.doc imtekda.doc jmlr.doc jpsj.doc kluwer.doc lps.doc macqassign.doc mentis.doc msuthesis.doc muthesis.doc nature.doc nddiss.doc nih.doc nostarch.doc nrc.doc onrannual.doc philosophersimprint.doc powerdot-FUBerlin.doc pracjourn.doc procIAGssymp.doc ptptex.doc psu-thesis.doc revtex.doc revtex4.doc ryethesis.doc sageep.doc seuthesis.doc soton.doc spie.doc stellenbosch.doc suftesi.doc sugconf.doc thesis-titlepage-fhac.doc thuthesis.doc toptesi.doc tugboat.doc tugboat-plain.doc uaclasses.doc uafthesis.doc ucdavisthesis.doc ucthesis.doc uiucthesis.doc umthesis.doc umich-thesis.doc unamthesis.doc ut-thesis.doc uothesis.doc uowthesis.doc uwthesis.doc vancouver.doc vxu.doc york-thesis.doc "
TEXLIVE_MODULE_SRC_CONTENTS="IEEEconf.source aastex.source acmconf.source active-conf.source aiaa.source aomart.source apa6e.source confproc.source dfgproposal.source ebsthesis.source elbioimp.source elsarticle.source elteikthesis.source erdc.source estcpmm.source euproposal.source fbithesis.source icsv.source ijmart.source imtekda.source jmlr.source kluwer.source lps.source mentis.source nddiss.source nostarch.source nrc.source philosophersimprint.source pracjourn.source revtex.source revtex4.source ryethesis.source sageep.source seuthesis.source stellenbosch.source thesis-titlepage-fhac.source thuthesis.source toptesi.source tugboat.source uaclasses.source ucdavisthesis.source uiucthesis.source uothesis.source vxu.source york-thesis.source "
inherit  texlive-module
DESCRIPTION="TeXLive Support for publishers, theses, standards, conferences, etc."

LICENSE="GPL-2 Apache-2.0 GPL-1 GPL-3 LPPL-1.2 LPPL-1.3 public-domain TeX-other-free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2011
!<dev-texlive/texlive-latexextra-2011
"
RDEPEND="${DEPEND} "
