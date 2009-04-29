# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

MY_PN="LinuxCupsPrinterPkg"

DESCRIPTION="PPD files of XEROX printers (CopyCentre, DocuPrint, Phaser, WorkCentre) for CUPS printing system"
HOMEPAGE="http://www.support.xerox.com/go/getfile.asp?objid=61334&prodID=6180"
SRC_URI="http://download.support.xerox.com/pub/drivers/DocuColor_2006/drivers/unix/en/${MY_PN}.tar.gz
		-> ${P}.tar"
LICENSE="Xerox"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-print/cups[ppds]"

S="${WORKDIR}/${MY_PN}"

RESTRICT="mirror bindist"

src_install() {
	dodoc Readme.txt || die "missing Readme.txt"
	insinto /usr/share/cups/model
	doins *.ppd || die "missing ppd files"
}
