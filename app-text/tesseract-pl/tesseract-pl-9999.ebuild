# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ESVN_REPO_URI="http://tesseract-polish.googlecode.com/svn/trunk/tessdata/"

inherit subversion

DESCRIPTION="Polish data files for tesseract OCR"
HOMEPAGE="http://code.google.com/p/tesseract-polish/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

src_install() {
	insinto /usr/share/tessdata
	doins pol.* || die "doins failed"

	dodoc ATTRIBUTIONS NOTICE || die "dodoc failed"
}
