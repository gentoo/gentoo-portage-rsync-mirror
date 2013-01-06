# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-pictures/texlive-pictures-2011-r1.ebuild,v 1.8 2012/10/03 18:24:43 ulm Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="adjustbox asyfig autoarea bardiag bloques bodegraph bondgraph cachepic chemfig combinedgraphics circuitikz curve curve2e curves dcpic diagmac2 doc-pictex dottex  dratex drs duotenzor eepic epspdfconversion esk fig4latex gincltex gnuplottex gradientframe grafcet here hvfloat knitting knittingpattern lpic mathspic miniplot numericplots pb-diagram petri-nets  pgf-soroban pgf-umlsd pgfgantt pgfopts pgfplots piano picinpar pict2e pictex pictex2 pinlabel pmgraph prerex productbox randbild randomwalk roundbox schemabloc swimgraf texdraw tikz-3dplot tikz-inet tikz-qtree tikz-timing tkz-base tkz-berge tkz-doc tkz-euclide tkz-fct tkz-graph tkz-kiviat tkz-linknodes tkz-orm tkz-tab tufte-latex xypdf xypic collection-pictures
"
TEXLIVE_MODULE_DOC_CONTENTS="adjustbox.doc asyfig.doc autoarea.doc bardiag.doc bloques.doc bodegraph.doc bondgraph.doc cachepic.doc chemfig.doc combinedgraphics.doc circuitikz.doc curve.doc curve2e.doc curves.doc dcpic.doc diagmac2.doc doc-pictex.doc dottex.doc dratex.doc drs.doc duotenzor.doc eepic.doc epspdfconversion.doc esk.doc fig4latex.doc gincltex.doc gnuplottex.doc gradientframe.doc grafcet.doc here.doc hvfloat.doc knitting.doc knittingpattern.doc lpic.doc mathspic.doc miniplot.doc numericplots.doc pb-diagram.doc petri-nets.doc pgf-soroban.doc pgf-umlsd.doc pgfgantt.doc pgfopts.doc pgfplots.doc piano.doc picinpar.doc pict2e.doc pictex.doc pinlabel.doc pmgraph.doc prerex.doc productbox.doc randbild.doc randomwalk.doc roundbox.doc schemabloc.doc swimgraf.doc texdraw.doc tikz-3dplot.doc tikz-inet.doc tikz-qtree.doc tikz-timing.doc tkz-base.doc tkz-berge.doc tkz-doc.doc tkz-euclide.doc tkz-fct.doc tkz-graph.doc tkz-kiviat.doc tkz-linknodes.doc tkz-orm.doc tkz-tab.doc tufte-latex.doc xypdf.doc xypic.doc "
TEXLIVE_MODULE_SRC_CONTENTS="adjustbox.source asyfig.source combinedgraphics.source curve.source curve2e.source curves.source dottex.source esk.source gincltex.source gnuplottex.source gradientframe.source petri-nets.source pgfgantt.source pgfopts.source pgfplots.source pict2e.source productbox.source randbild.source randomwalk.source tikz-timing.source "
inherit  texlive-module
DESCRIPTION="TeXLive Graphics packages and programs"

LICENSE="GPL-2 Apache-2.0 GPL-1 GPL-3 LPPL-1.3 public-domain TeX-other-free"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
!<dev-texlive/texlive-latexextra-2009
!<dev-texlive/texlive-texinfo-2009
"
RDEPEND="${DEPEND}"
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/cachepic/cachepic.tlu texmf-dist/scripts/fig4latex/fig4latex texmf-dist/scripts/mathspic/mathspic.pl"
